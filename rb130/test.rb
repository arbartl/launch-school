require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

class EqualityTest < Minitest::Test
  def test_value_equality
    str1 = "hello"
    str2 = "hello"

    assert_equal(str1, str2)
    assert_same(str1, str2)
  end
end