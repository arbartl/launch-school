class Minilang
  def initialize(instructions)
    @stack = []
    @register = 0
    @instructions = instructions.split(' ')
  end

  def eval
    @instructions.each do |instruction|
      case instruction
      when /[0-9]/
        @register = instruction.to_i
      when 'PRINT'
        puts @register
      when 'PUSH'
        @stack << @register
      when 'POP'
        begin
          stack_empty?(@stack)
        rescue RuntimeError => e
          puts e.message
          break
        end
        @register = @stack.pop
      when 'ADD'
        begin
          stack_empty?(@stack)
        rescue RuntimeError => e
          puts e.message
          break
        end
        @register += @stack.pop
      when 'SUB'
        begin
          stack_empty?(@stack)
        rescue RuntimeError => e
          puts e.message
          break
        end
        @register -= @stack.pop
      when 'MULT'
        begin
          stack_empty?(@stack)
        rescue RuntimeError => e
          puts e.message
          break
        end
        @register *= @stack.pop
      when 'DIV'
        begin
          stack_empty?(@stack)
        rescue RuntimeError => e
          puts e.message
          break
        end
        @register /= @stack.pop
      when 'MOD'
        begin
          stack_empty?(@stack)
        rescue RuntimeError => e
          puts e.message
          break
        end
        @register %= @stack.pop
      else
        begin
          invalid_token(instruction)
        rescue RuntimeError => e
          puts e.message
          break
        end
      end
    end
    begin
      no_print(@instructions)
    rescue RuntimeError => e
      puts e.message
    end
  end

  private

  attr_accessor :stack, :register

  def stack_empty?(stack)
    raise("Empty stack!") if stack.empty?
  end

  def invalid_token(instruction)
    raise("Invalid token: #{instruction}")
  end

  def no_print(instructions)
    raise("(nothing printed; no PRINT commands)") unless instructions.include?('PRINT')
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
## 15
#
Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
## 5
## 3
## 8
#
Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
## 10
## 5
#
Minilang.new('5 PUSH POP POP PRINT').eval
## Empty stack!
#
Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
## 6
#
Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
## 12
#
Minilang.new('-3 PUSH 5 XSUB PRINT').eval
## Invalid token: XSUB
#
Minilang.new('-3 PUSH 5 SUB PRINT').eval
## 8
#
Minilang.new('6 PUSH').eval
## (nothing printed; no PRINT commands)