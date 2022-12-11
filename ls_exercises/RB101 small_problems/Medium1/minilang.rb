def minilang(str)
  operators = { 'ADD' => '+', 'SUB' => '-', 'MULT' => '*', 'DIV' => '/', 'MOD' => '%' }
  keywords = ['PUSH', 'PRINT', 'POP']
  register = 0
  stack = []
  cmds = str.split(' ')
  until cmds.empty?
    register = cmds.shift if cmds[0] =~ /[0-9]/
    if keywords.include?(cmds[0].upcase)
      case cmds[0].upcase
      when keywords[0] then stack << register
      when keywords[1] then puts register
      when keywords[2] then register = stack.pop
      end
    elsif operators.keys.include?(cmds[0].upcase)
      expression = "#{register.to_s} #{operators[cmds[0].upcase]} #{stack.pop.to_s}"
      register = eval(expression).to_i
    end
    cmds.shift
  end
end

# Further Exploration