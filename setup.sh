# Setup virtual environment and set environment
# to use this framework
# Just execute `source setup.sh`

FAIL=1
SUCCESS=0
CURRENT_DIR=`pwd`
TEMP=/tmp
VENV=$CURRENT_DIR/v_env

function usage {
    echo -n "
Usage:
  source setup.sh
"
}

function print_echo {
    echo
    echo "==> $@"
}

function execute_cmd {
    echo "Executing: $@"
    eval $@
    rc=$?
    echo "Done"
    echo
    return $rc
}

function test_setup {
    print_echo "Setting up environment variables"
    PYTHONPATH=$CURRENT_DIR:$PYTHONPATH
    PATH=$CURRENT_DIR:$PATH
    export CURRENT_DIR PYTHONPATH PATH
    echo "Done"
    echo

    # Remove all *.pyc files
    print_echo "Removing all *.pyc files"
    execute_cmd "find $CURRENT_DIR -name \"*.pyc\" -exec rm -f {} \;"

    # If already in virtual environment, deactivate
    print_echo "Attempting to deactivating current virutal environment, if any"
    execute_cmd "deactivate 2>/dev/null"

    # Create virtual environment
    print_echo "Creating virtual environment at $VENV"
    cmd_suffix=""
    python_to_use=$(which python2.7)
    if [ "$python_to_use" != "" ]; then
        cmd_suffix="-p $python_to_use"
    fi
    execute_cmd "virtualenv $cmd_suffix $VENV"
    if [ $? -ne $SUCCESS ]; then
        print_echo "Could not create virtual environment"
        return $FAIL
    fi

    # Activate virtual environment
    print_echo "Activating virtual environment"
    execute_cmd "source $VENV/bin/activate"

    # Upgrading the pip and setuptools
    print_echo "Upgrading the pip and setuptools"
    execute_cmd "pip install --upgrade pip setuptools"

    print_echo "Installing requirements,setting up environment"
    execute_cmd "pip install -r $CURRENT_DIR/requirements.txt"
    if [ $? -ne $SUCCESS ]; then
        print_echo "Could not install all the requirements"
        return $FAIL
    fi
}

function install_virtualenv {
    print_echo "Installing virtualenv using sudo (please type password if prompted)"
    execute_cmd "sudo pip install -U virtualenv"
    if [ $? -ne $SUCCESS ]; then
        print_echo "Could not install virtualenv"
        return $FAIL
    fi
    return $SUCCESS
}

function check_cmd_installed {
    print_echo "Checking if $1 is installed or not"
    execute_cmd "type $1 &> /dev/null"
    if [ $? -ne $SUCCESS ]; then
        print_echo "$1 is not installed"
        return $FAIL
    fi
    print_echo "$1 is already installed"
    return $SUCCESS
}

function install_pip {
    print_echo "Installing PIP"
    check_cmd_installed curl
    if [ $? -ne $SUCCESS ]; then
        print_echo "$1 is not installed"
        return $FAIL
    fi
    print_echo "Installing pip..............."
    print_echo "Downloading get-pip.py"
    execute_cmd \
        "curl https://bootstrap.pypa.io/get-pip.py -o $TEMP/get-pip.py"

    print_echo "Installing pip using sudo (please type password if prompted)"
    execute_cmd "sudo python $TEMP/get-pip.py"
    if [ $? -ne $SUCCESS ]; then
        print_echo "Could not install pip"
        return $FAIL
    fi
    return $SUCCESS

}

function install_virtualenv {
    print_echo "Installing Virtualenv module................."
    execute_cmd "sudo pip install -U virtualenv"
    if [ $? -ne $SUCCESS ]; then
        print_echo "virtualenv is not installed"
        return $FAIL
    fi
    print_echo "virtualenv is installed"
    return $SUCCESS
}

function check_requirements {
    print_echo "Checking if requirements are met"
    requirements_met=$SUCCESS

    # Check if pip is installed and install if necessary
    check_cmd_installed pip || install_pip
    if [ $? -ne $SUCCESS ]; then
        requirements_met=$FAIL
    fi

    # Check if virtualenv is installed and install if necessary
    check_cmd_installed virtualenv || install_virtualenv
    if [ $? -ne $SUCCESS ]; then
        requirements_met=$FAIL
    fi

    if [ $requirements_met -ne $SUCCESS ]; then
        echo "Requirements are not met."
        echo
        return $FAIL
    else
        echo "Requirements are met."
        echo
        return $SUCCESS
    fi
}

check_requirements
if [ $? -ne $SUCCESS ]; then
    print_echo "Requirements are not met!!!!!!!!!! :("
fi
print_echo "Requirements are okay............  :)"

test_setup
if [ $? -ne $SUCCESS ]; then
    echo "Test setup Failed!!!!!!!!!! :("
    return 1
fi
print_echo "Test Setup successful............  :)"
