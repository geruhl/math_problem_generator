require 'optparse'
require_relative 'math_problems'

options = {}
OptionParser.new do |opts|
  opts.banner =  'Usage: gen_math_problems.rb [options]'
  opts.separator '       Generate addition and math problems of varying sizes'
  opts.separator ''
  opts.separator 'Specific options:'
  opts.on('-l', '--number_length [Integer]', Integer, 'Maximum length for each number') {|l| options[:num_length] = l}
  opts.on('-o', '--operands_per_problem [Integer]', Integer, 'Number of operands per problem') {|o| options[:oprnd_per_problem] = o}
  opts.on('-n', '--num_problems [Integer]', Integer, 'Number of problems to generate') {|n| options[:num_problems] = n}
  opts.on('-c', '--column_width [Integer]', Integer, 'Column width of output') {|c| options[:col_width] = c}
  opts.on('-a', '--addition', 'Generate addition problems (default)') {|a| options[:addition] = a}
  opts.on('-s', '--subtraction', 'Generate subtraction problems') {|s| options[:subtract] = s}

  opts.on_tail('-h', '--help', 'Show this message') do
    puts opts
    exit
  end
end.parse!

math_prob = MathProblems.new
math_prob.number_length = options[:num_length] unless options[:num_length].nil?
math_prob.numbers_per_problem = options[:oprnd_per_problem] unless options[:oprnd_per_problem].nil?
math_prob.number_of_problems = options[:num_problems] unless options[:num_problems].nil?
math_prob.out_column_width = options[:col_width] unless options[:col_width].nil?
math_prob.update_operations(add: false, subtract: false)
math_prob.update_operations(add: true) if options[:addition]
math_prob.update_operations(subtract: true) if options[:subtract]

puts math_prob.design_problems
