import pytest


class TestClass(object):

  @staticmethod
  @pytest.fixture(scope="function")
  def db_connect(request):
    print "[TEST MODULE] DB connected......."
    yield True
    print "\n[TEST MODULE] DB Disconnected......."

  def setup_class(cls):
    print "\n=========== Setup Class.................."

  def teardown_class(cls):
    print "========== Teardown Class.................."


  def setup_method(self):
    print "\n------- Setup method Completed............"

  def teardown_method(self):
    print "\n------- Teardown method Completed.............."

  def hi(self):
    print "HI......................."

  @pytest.mark.parametrize("t", ["t", "h", "s"])
  def test_parametrize(self, t, db_connect):
    x = "this"
    assert t in x
    print db_connect

  def test_one(self, config_data):
    x = "1234567890"
    for i in config_data:
      print "Test input : ", i
      assert str(i) in x
      print "success"

  def test_two(self, config_data):
    x = "hello"
    assert hasattr(x, config_data)
    print config_data

  def test_three(self, config_data):
    print "Test Three"
    print config_data

  def test_four(self, config_data):
    print "Test four"
    print config_data

  def test_set_comparison(self, config_data):
    set1 = set("1308")
    set2 = set(config_data)
    assert set1 != set2
    print config_data