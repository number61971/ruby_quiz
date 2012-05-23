#!/usr/bin/env ruby

digits = ('1'..'9').to_a

operand_sequences = [
  ['-','-','+'],
  ['-','+','-'],
  ['+','-','-'],
]

formulas = []
operand_sequences.each do |op_seq|
  op1_idx = 0
  while op1_idx < 6
    op1_idx += 1

    op2_idx = op1_idx
    while op2_idx < 7
      op2_idx += 1

      op3_idx = op2_idx
      while op3_idx < 8
        op3_idx += 1

        formula = Array.new(digits)
        formula.insert(op3_idx, " #{op_seq[2]} ")
        formula.insert(op2_idx, " #{op_seq[1]} ")
        formula.insert(op1_idx, " #{op_seq[0]} ")
        formula = formula.join('')
        formula = {:expression => formula, :result => eval(formula)}
        formulas.push(formula)

        output = "#{formula[:expression]} = #{formula[:result]}"
        if formula[:result] == 100
          output = "************************\n#{output}\n************************"
        end
        puts output
      end
    end
  end
end
puts "\n#{formulas.select{|f| f[:result] == 100}.length} out of #{formulas.length} possible equations resulted in 100"
