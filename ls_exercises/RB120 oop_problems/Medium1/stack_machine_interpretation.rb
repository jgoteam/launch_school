class EmptyStackError < StandardError; end
class InvalidTokenError < StandardError; end

class Minilang
  MATH_OP  = { "ADD" => :+, "SUB" => :-, "MULT" => :*, "DIV" => :/, "MOD" => :% }
  STACK_OP = %w(PRINT PUSH POP)
  private_constant :MATH_OP, :STACK_OP

  def initialize(str)
    @register = 0
    @stack = []
    @orders = str.strip.squeeze(' ').split
  end

  def eval
    until orders.empty?
      if orders[0].match?(/-?[0-9]/)
        set_register
      elsif MATH_OP.keys.include?(orders[0])
        do_math_op
      elsif STACK_OP.include?(orders[0])
        do_stack_op
      else
        raise InvalidTokenError, "Invalid token: #{orders[0]}"
      end
    end
  end

  private

  attr_accessor :orders

  def set_register
    @register = @orders.shift.to_i
  end

  def do_math_op
    raise EmptyStackError, "Empty stack!" if @stack.empty?
    @register = @register.send(MATH_OP[@orders.shift], @stack.pop)
  end

  def do_stack_op
    send(@orders.shift.downcase)
  end

  def print
    puts @register
  end

  def push
    @stack << @register
  end

  def pop
    raise EmptyStackError, "Empty stack!" if @stack.empty?
    @register = @stack.pop
  end
end


Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# # 5
# # 3
# # 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# # 10
# # 5

Minilang.new('5 PUSH POP POP PRINT').eval
# # Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# # 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# # 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# # Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# # 8

Minilang.new('6 PUSH').eval
# # (nothing printed; no PRINT commands)