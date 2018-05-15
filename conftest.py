import pytest


@pytest.fixture(scope="function", autouse=True)
def testdata():
  print "\n[CONFTEST FIXTURE] Test data........................ from conftest.py"

