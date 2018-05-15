import pytest



class TestClass(object):

  @staticmethod
  @pytest.fixture(scope="function", autouse=True)
  def db_connect(request):
    print "[TEST MODULE] DB connected......."
    yield True
    print "[TEST MODULE] DB Disconnected......."

  def setup_class(cls):
    print "=========== Setup Class.................."

  def teardown_class(cls):
    print "========== Teardown Class.................."

  def setup(self):
    print "------- Setup method done............"

  def teardown(self):
    print "------- Teardown method.............."

  def hi(self):
    print "HI......................."

  @pytest.mark.parametrize("t", ["t", "i", "s"])
  def test_one(self, t):
    x = "this"
    assert t in x

  def test_two(self):
    x = "hello"
    assert hasattr(x, 'split')

  def test_three(self):
    print "Test Three"

  def test_four(self):
    print "Test four"

  def test_set_comparison(self):
    set1 = set("1308")
    set2 = set("8035")
    assert set1 != set2
