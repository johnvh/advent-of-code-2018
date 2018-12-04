#!/usr/bin/env ruby

input = File.readlines './input.txt'

freqs = input.collect do |id|
    id = id.strip
    {
      id: id,
      freq: id
        .split('')
        .group_by { |c| c }
        .collect { |c, occurences| [c, occurences.size] }
        .to_h
    }
  end

num_2 = freqs.select do |d|
  d[:freq].collect { |v| v[1] == 2 }.any?
end
num_3 = freqs.select do |d|
  d[:freq].collect { |v| v[1] == 3 }.any?
end

puts 'checksum:'
puts num_2.size * num_3.size
