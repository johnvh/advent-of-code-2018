#!/usr/bin/env ruby

require 'set'

def parse_input(input)
  input.collect(&:to_i)
end

input = File.readlines('./input.txt')
puts "part 1, resulting frequency:"
puts parse_input(input).inject(0, &:+)

def first_dup(input)
  seen = Set.new
  freq = 0
  parse_input(input).cycle do |change|
    freq = freq + change
    if seen.include? freq
      break
    end
    seen.add freq
  end
  freq
end

# puts first_dup(%w[+1 -1])
# puts first_dup(%w[+3 +3 +4 -2 -4])

puts "part 2, first duplicate frequency:"
puts first_dup(input)
