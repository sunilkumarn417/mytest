import pytest
import pathlib
import json


@pytest.yield_fixture(scope="class", autouse=True)
def test_config(request):
  f = pathlib.Path(request.node.fspath.strpath)
  print "File : %s" % f
  config = f.with_name("config.json")
  print "Config json file : %s" % config
  with config.open() as fd:
    testdata = json.loads(fd.read())
  print "test data :", testdata
  yield testdata


@pytest.yield_fixture(scope="function", autouse=True)
def config_data(request, test_config):
  testdata = test_config
  test = request.function.__name__
  if test in testdata:
    test_args = testdata[test]
    yield test_args
  else:
    yield {}
