#!/usr/bin/env ruby

# --- Day 7: Some Assembly Required ---
#
# This year, Santa brought little Bobby Tables a set of wires and bitwise logic gates! Unfortunately, little Bobby is a little under the recommended age range, and he needs help assembling the circuit.
#
# Each wire has an identifier (some lowercase letters) and can carry a 16-bit signal (a number from 0 to 65535). A signal is provided to each wire by a gate, another wire, or some specific value. Each wire can only get a signal from one source, but can provide its signal to multiple destinations. A gate provides no signal until all of its inputs have a signal.
#
# The included instructions booklet describe how to connect the parts together: x AND y -> z means to connect wires x and y to an AND gate, and then connect its output to wire z.
#
# For example:
#
# 123 -> x means that the signal 123 is provided to wire x.
# x AND y -> z means that the bitwise AND of wire x and wire y is provided to wire z.
# p LSHIFT 2 -> q means that the value from wire p is left-shifted by 2 and then provided to wire q.
# NOT e -> f means that the bitwise complement of the value from wire e is provided to wire f.
# Other possible gates include OR (bitwise OR) and RSHIFT (right-shift). If, for some reason, you'd like to emulate the circuit instead, almost all programming languages (for example, C, JavaScript, or Python) provide operators for these gates.
#
# For example, here is a simple circuit:
#
# 123 -> x
# 456 -> y
# x AND y -> d
# x OR y -> e
# x LSHIFT 2 -> f
# y RSHIFT 2 -> g
# NOT x -> h
# NOT y -> i
# After it is run, these are the signals on the wires:
#
# d: 72
# e: 507
# f: 492
# g: 114
# h: 65412
# i: 65079
# x: 123
# y: 456
#
# In little Bobby's kit's instructions booklet (provided as your puzzle input), what signal is ultimately provided to wire a?

WIRES = {}

class Wire
  attr_accessor :name, :input

  def initialize(name, input=nil)
    @name  = name
    @input = input
  end

  def signal
    return input.signal if input
    0
  end
end

class Gate
  attr_accessor :function

  def initialize(inputs, function)
    @input1, @input2   = inputs
    @function = function
  end

  def input1
    return nil unless @input1
    if @input1 =~ /[A-Za-z]/
      WIRES[@input1].signal
    else
      @input1.to_i
    end
  end

  def input2
    return nil unless @input2
    if @input2 =~ /[A-Za-z]/
      WIRES[@input2].signal
    else 
      @input2.to_i
    end
  end

  def inputs_satisfied?
    inputs = [input1,input2].flatten.count
    return inputs == 1 if @function == 'NOT'
    inputs == 2
  end

  def signal
    return 0 unless inputs_satisfied?
    case function
    when 'AND'
      return input1 & input2
    when 'OR'
      return input1 | input2
    when 'NOT'
      return ~input1
    when 'LSHIFT'
      return input1 << input2
    when 'RSHIFT'
      return input1 >> input2
    when 'DIRECT'
      return input1
    end
  end
end

def assemble(operator, output, inputs)
  gate = Gate.new(inputs, operator)
  inputs.each do |input|
    if input =~ /[A-z][a-z]/
      WIRES[input] ||= Wire.new(input)
    end
  end
  if WIRES[output]
    WIRES[output].input = gate
  else
    WIRES[output] = Wire.new(output, gate)
  end
end

instructions.each do |instruction|
  if instruction.include?('AND')
    wire_a, wire_b, wire_c = instruction.scan(/(\S+) AND (\S+) -> (\w+)/).flatten
    assemble('AND', wire_c, [wire_a, wire_b])
  elsif instruction.include?('OR')
    wire_a, wire_b, wire_c = instruction.scan(/(\S+) OR (\S+) -> (\w+)/).flatten
    assemble('OR', wire_c, [wire_a, wire_b])
  elsif instruction.include?('NOT')
    wire_a, wire_b = instruction.scan(/NOT (\S+) -> (\w+)/).flatten
    assemble('NOT', wire_b, [wire_a])
  elsif instruction.include?('LSHIFT')
    wire_a, shift_val, wire_b = instruction.scan(/(\S+) LSHIFT (\d+) -> (\w+)/).flatten
    assemble('LSHIFT', wire_b, [wire_a, shift_val])
  elsif instruction.include?('RSHIFT')
    wire_a, shift_val, wire_b = instruction.scan(/(\S+) RSHIFT (\d+) -> (\w+)/).flatten
    assemble('RSHIFT', wire_b, [wire_a, shift_val])
  elsif instruction =~ /\S+ -> \w+/
    wire_a, wire_b = instruction.scan(/(\S+) -> (\w+)/).flatten
    assemble('DIRECT', wire_b, [wire_a])
  end
end

p WIRES['lx'].signal
