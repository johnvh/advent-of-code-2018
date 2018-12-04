#!/usr/bin/env ruby
# frozen_string_literal: true

Claim = Struct.new(*%i[id l t w h])

input = File.readlines('./input.txt').collect do |ln|
  _, id, l, t, w, h = ln.match(
    /#(\d+)\ @ (\d+),(\d+): (\d+)x(\d+)/
  ).to_a.map(&:to_i)
  Claim.new  id, l, t, w, h
end

grid = Array.new(1_000).collect { |r| Array.new(1_000, 0) }

input.each do |claim|
  claim.h.times do |h|
    claim.w.times do |w|
      grid[claim.t + h][claim.l + w] += 1
    end
  end
end

puts "overlapping:"
puts grid.flatten.count { |n| n >= 2 }

def claim_squares(grid, claim)
  squares = []
  claim.h.times do |h|
    squares << grid[claim.t + h][claim.l...claim.l + claim.w]
  end
  squares
end

input.each do |claim|
  if claim_squares(grid, claim).flatten.all? { |n| n == 1 }
    puts "lone claim:"
    puts claim
    break;
  end
end
