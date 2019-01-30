require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'math_problems'

reporter_options = { color: true }

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

class BigTest < MiniTest::Test
  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @math_p = MathProblems.new
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_get_a_random_digit
    assert(@math_p.send(:rand_digit))
  end

  def test_rand_digit_between_0_and_10
    digit = @math_p.send(:rand_digit)
    assert((digit >= 0) & (digit <= 10))
  end

  def test_rand_digit_is_integer
    assert_kind_of(Integer, @math_p.send(:rand_digit))
  end

  def test_set_number_length
    assert(@math_p.number_length = 10)
  end

  def test_set_operations_type
    assert(@math_p.update_operations(subtract: true))
  end

  def test_set_operations_types
    @math_p.update_operations(subtract: true, add: false)
    assert(@math_p.subtract?)
    assert(!@math_p.add?)
  end

  def test_generate_10_digit_number
    @math_p.number_length = 10
    assert_equal(19, @math_p.send(:generate_number).length)
  end

  def test_set_numbers_per_problem
    assert(@math_p.numbers_per_problem = 8)
  end

  def test_generate_two_operand_addition_problem
    @math_p.number_length = 10
    @math_p.numbers_per_problem = 2
    assert_equal(70, @math_p.send(:design_problems).length)
  end

  def test_generate_three_operand_addition_problem
    @math_p.number_length = 10
    @math_p.numbers_per_problem = 4
    @math_p.number_of_problems = 1
    assert_equal(114, @math_p.send(:design_problems).length)
  end

  def test_set_number_of_problems
    assert(@math_p.number_of_problems = 3)
  end

  def test_generate_3_problems
    @math_p.number_length = 10
    @math_p.numbers_per_problem = 3
    @math_p.number_of_problems = 3
    assert_equal(340, @math_p.design_problems.length)
  end

  def test_generate_subtraction_problem
    @math_p.update_operations(subtract: true, add: false)
    assert_match(/- /, @math_p.design_problems)
  end

  def test_generate_both_operands
    @math_p.update_operations(subtract: true, add: true)
    assert_match(/(- )|(\+ )/, @math_p.design_problems)
  end

  def test_negative_number_fix
    problem = "  1 2 1 3 4 5 5\n- 6 2 1 3 4 5 5"
    fixed_problem = "  1 2 1 3 4 5 5\n-   2 1 3 4 5 5"
    assert_equal(fixed_problem, @math_p.send(:fix_negative_subtractions, problem))
  end

  def test_set_column_width
    assert(@math_p.out_column_width = 80)
  end

  def test_two_column_output
    @math_p.out_column_width = 60
    @math_p.number_length = 10
    @math_p.number_of_problems = 3
    assert_equal(10, @math_p.design_problems.split("\n").length)
  end

end

#
# Local Variables:
# mode: ruby
# tab-width: 2
# ruby-indent-level: 2
# indent-tabs-mode: nil
# End:
#
# vim: set filetype=ruby tabstop=2 shiftwidth=2 expandtab :
#
