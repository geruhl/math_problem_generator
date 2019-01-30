class MathProblems
  attr_writer :number_length, :numbers_per_problem, :number_of_problems, :out_column_width

  def initialize
    @number_length = 2
    @numbers_per_problem = 2
    @number_of_problems = 1
    @out_column_width = 80
    @problems = []
    @operations = { add: true, subtract: false }
  end

  def design_problems
    generate_problems
    print_problems
  end

  def generate_problems
    @problems = (1..@number_of_problems).collect { |_num| generate_problem }
  end

  def print_problems
    (1..calculate_problem_rows).each_with_object('') do |problem_row, out_str|
      out_str << generate_row_of_problems(problem_row)
    end
  end

  def update_operations(*op_type)
    op_type[0].each do |k, v|
      @operations[k] = v
    end
  end

  def subtract?
    @operations[:subtract]
  end

  def add?
    @operations[:add]
  end

  private

  def generate_row_of_problems(problem_row)
    row_of_problems = (0..@numbers_per_problem).each_with_object('') do |row, out_str|
      out_str << generate_output_row(problem_row, row)
    end
    row_of_problems + "\n\n\n\n"
  end

  def generate_output_row(problem_row, row)
    output_row = (1..calculate_columns).each_with_object('') do |col, out_str|
      out_str << put_number_for_problem(col, problem_row, row)
    end
    output_row.rstrip! + "\n"
  end

  def calculate_problem_rows
    (@number_of_problems.to_f / calculate_columns.to_f).ceil
  end

  def calculate_columns
    cols, remain = @out_column_width.divmod((@number_length * 2) + 10)
    cols += 1 if remain >= (@number_length * 2)
    cols
  end

  def put_number_for_problem(c, pr, row)
    if (pr * c) <= @problems.length
      @problems[pr * c - 1][row] + (' ' * 10)
    else
      ''
    end
  end

  def generate_problem
    op = operand # outside the loop so we don't mix operands in each problem
    problem = (2..@numbers_per_problem).each_with_object(generate_first_number) do |_num, str|
      str << "\n#{op} " + generate_number
      fix_negative_subtractions(str) if subtract?
    end
    (problem + generate_problem_end).split("\n")
  end

  def fix_negative_subtractions(str)
    /(?<first_digit>\d)(.|\n)*- (?<second_digit>\d)/ =~ str
    if second_digit.to_i >= first_digit.to_i
      str.sub!(/(  \d(.|\n)*- )\d([\d ]+)/, '\1 \3')
    end
    str
  end

  def operand
    if subtract? & add?
      rand(0..1) == 1 ? '-' : '+'
    elsif subtract?
      '-'
    else
      '+'
    end
  end

  def generate_first_number
    '  ' + generate_number
  end

  def generate_problem_end
    "\n" + ('--' * @number_length) + '-'
  end

  def generate_number
    replace_leading_0_with_spc((1..@number_length).each_with_object('') do |_num, str|
      str << rand_digit.to_s << ' '
    end.strip)
  end

  def replace_leading_0_with_spc(num)
    num.sub!(/^( *)(0 )/, '\1  ') while num =~ /^ *0 /
    num
  end

  def rand_digit
    rand(9)
  end
end
