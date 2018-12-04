#!/usr/bin/env ruby
# frozen_string_literal: true

input = File.readlines('./input.txt').collect(&:strip)

# String -> String -> [Int]
def diff_count(a, b)
  a.chars.each.with_index
    .inject([]) do |indexes, (c, i)|
      indexes << i if c != b[i]
      indexes
    end
end

# p diff_count(*%w[fghij fguij])
# p diff_count(*%w[abcde axcye])

input.combination(2).each do |pair|
  diff = diff_count(*pair)
  if diff.size == 1
    puts "difference of 1:"
    p pair
    chars = pair[0].chars
    chars.delete_at(diff.first)
    puts "common chars:"
    puts chars.join
    break
  end
end
