# math_problem_generator
This generates basic addition and subtraction problems with a user-defined number of digits, operands, and column widths.

```
ruby gen_math_problems.rb <args>
  
ruby gen_math_problems.rb -l 53 -o 20 -n 10 -c 80 -a

-l or --number_length.  Integer, Maximum length for each number

-o or --operands_per_problem.  Integer, Number of operands per problem

-n or --num_problems.  Integer, Number of problems to generate

-c or --column_width.  Integer, Column width of output

-a or --addition.  Generate addition problems (default)

-s or --subtraction.  Generate subtraction problems
```
