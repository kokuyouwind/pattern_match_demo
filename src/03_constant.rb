# 定数を指定してマッチできる
puts "match with constant"
case 1
in String
  fail # マッチしない
in Integer
  puts "1 is Integer"
end

# 定数と配列を合わせて指定できる
puts "array with constant"
Point = Struct.new(:x, :y)
case Point.new(1, 2)
in Point[x, y]
  puts "x: #{x}, y: #{y}" # => x: 1, y: 2
end

# 定数とハッシュを合わせて指定できる
puts "hash with constant"
case Point.new(3, 4)
in Point(x: x, y: y)
  puts "x: #{x}, y: #{y}" # => x: 3, y: 4
end

# ===を定義すればマッチ条件を変えられる
# `case` ではなく `in` (パターン側)が使われる
puts "define === method"
class Tester
  def self.===(other)
    other.nil?
  end
end
case nil
in Tester
  puts "nil matched"
end
