require 'active_pattern'

puts "parity check with active pattern"

module Parity
  extend ActivePattern::Context[Integer]
  Even = pattern { self % 2 == 0 }
  Odd = pattern { self % 2 != 0 }
end

def test_number(input)
  case input
  in Parity::Even; puts "#{input} is even"
  in Parity::Odd;  puts "#{input} is odd"
  end
end

test_number 7  # =>  7 is odd
test_number 11 # => 11 is odd
test_number 32 # => 32 is even
