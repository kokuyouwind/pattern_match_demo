require 'active_pattern'

# == Parity Check

puts "== Parity Check with active pattern"

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

# == Coordinates

puts "== Coordinates with active pattern"

Point = Struct.new(:x, :y)

module Coordinates
  extend ActivePattern::Context[Point]
  Cartesian = pattern { [x, y] }
  Polar = pattern { [Math.sqrt(x ** 2 + y ** 2), Math.atan2(y, x)] }
end

point = Point.new(3, 4)

point in Coordinates::Cartesian[x, y]
puts "Catesian: (#{x}, #{y})" #=> (3, 4)

point in Coordinates::Polar[r, theta]
puts "Polar: (#{r}, #{theta})" #=> (5.0, 0.9272952180016122)
