### -------     SAMPLE TESTS     ------

```$ pytest -s -v test_class.py
============================= test session starts ==============================
platform linux2 -- Python 2.7.12, pytest-3.5.1, py-1.5.3, pluggy-0.6.0 -- /usr/bin/python
cachedir: .pytest_cache
rootdir: /home/asm/mytest/test_cases/project_2, inifile:
collecting ... collected 8 items

test_class.py::TestClass::test_parametrize[t] 
=========== Setup Class..................
File : /home/asm/mytest/test_cases/project_2/test_class.py
Config json file : /home/asm/mytest/test_cases/project_2/config.json
test data : {u'test_set_comparison': u'34567', u'test_one': [4, 5, 6], u'test_four': {u'four': 4}, u'test_three': {u'three': 3}, u'test_two': u'join'}

------- Setup method done............
PASSED
------- Teardown method..............

test_class.py::TestClass::test_parametrize[h] 
------- Setup method done............
PASSED
------- Teardown method..............

test_class.py::TestClass::test_parametrize[s] 
------- Setup method done............
PASSED
------- Teardown method..............

test_class.py::TestClass::test_one 
------- Setup method done............
Test input :  4
success
Test input :  5
success
Test input :  6
success
PASSED
------- Teardown method..............

test_class.py::TestClass::test_two 
------- Setup method done............
join
PASSED
------- Teardown method..............

test_class.py::TestClass::test_three 
------- Setup method done............
Test Three
{u'three': 3}
PASSED
------- Teardown method..............

test_class.py::TestClass::test_four 
------- Setup method done............
Test four
{u'four': 4}
PASSED
------- Teardown method..............

test_class.py::TestClass::test_set_comparison 
------- Setup method done............
34567
PASSED
------- Teardown method..............
========== Teardown Class..................


=========================== 8 passed in 0.02 seconds ===========================
```
