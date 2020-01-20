# クラスを指定してマッチできる
puts "match with class"
case 1
in String
  fail # マッチしない
in Integer
  puts "1 is Integer"
end

# クラスと配列を合わせて指定できる
puts "array with class"
Point = Struct.new(:x, :y)
case Point.new(1, 2)
in Point[x, y]
  puts "x: #{x}, y: #{y}" # => x: 1, y: 2
end

# クラスとハッシュを合わせて指定できる
puts "hash with class"
case Point.new(3, 4)
in Point(x: x, y: y)
  puts "x: #{x}, y: #{y}" # => x: 3, y: 4
end

# ===を定義すればマッチ条件を変えられる
# `case` ではなく `in` に書かれたクラスのほうが使われる
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
