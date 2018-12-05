#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pry-byebug'

input = File.readlines('./input.txt').map(&:strip).sort

guards = Hash.new { |h, k| h[k] = [] }
guard = nil
sleeping = []

input.each do |log|
  _, hour, minute = log.match(/(\d+):(\d+)\]/).to_a

  case log
  when /Guard/
    if guard
      sleeping << 59 if sleeping.size.odd?
      guards[guard] << sleeping
      sleeping = []
    end

    guard = log.match(/#(\d+)/)[1]
  when /wakes/
    sleeping << minute.to_i - 1
  when /asleep/
    sleeping << minute.to_i
  end
end

g = guards
  .reject { |_, sleeping| sleeping.empty? }
  .collect do |guard_id, sleeping|
    [
      guard_id,
      sleeping.flatten.each_slice(2).collect { |a, b| (a..b) }
    ]
  end

def strategy_1(guards)
  puts "strategy 1"

  sleepiest_guard = guards.max_by { |guard_id, sleeping| sleeping.collect(&:size).sum }
  puts "  sleepiest guard:  #{sleepiest_guard.first}"

  minute = sleepiest_guard[1]
    .flat_map(&:to_a)
    .flatten
    .group_by(&:itself)
    .max_by { |n, occur| occur.size }
    .first

  puts "  sleepiest minute: #{minute}"
  puts "  answer: #{sleepiest_guard.first.to_i * minute.to_i}"
end

strategy_1 g

def strategy_2(guards)
  puts "strategy 2"

  g = guards
    .collect do |guard_id, ranges|
      [
        guard_id,
        ranges
          .collect(&:to_a)
          .flatten
          .group_by(&:itself)
          .collect { |min, occur| [min, occur.size] }
          .max_by { |min, freq| freq }
      ]
    end
    .reject { |_, freq| freq.nil? }
    .max_by { |_, (min, freq)| freq }

  puts "  sleepiest guard: #{g.first}"
  puts "  sleepiest minute: #{g[1]}"
  puts "  answer: #{g.first.to_i * g[1].first.to_i}"
end

strategy_2 g
