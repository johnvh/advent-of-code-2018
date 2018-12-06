#!/usr/bin/env ruby
# frozen_string_literal: true

polymer = File.read('./input.txt').chomp
puts "original size: #{polymer.size}"

def react(poly)
  units = ('a'..'z')
    .to_a
    .map { |c| [
      [c.upcase, c.downcase].join,
      [c.downcase, c.upcase].join
    ]}
    .flatten
    .freeze

  while true
    start_size = poly.size
    units.each do |unit|
      poly.gsub! unit, ''
    end
    break if poly.size == start_size
  end
  poly
end

puts "reacted size: #{react(polymer.dup).size}"

unit_sizes = {}

('a'..'z').to_a.each do |c|
  poly = polymer.gsub(c, '').gsub(c.upcase, '')
  unit_sizes[c] = react(poly).size
end

puts "shortest: #{unit_sizes.min_by { |_, size| size }[1]}"
