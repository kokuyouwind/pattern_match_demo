# 配列の要素ごとにパターンマッチできる
puts "basic pattern"
case [1, 2, 3]
in [2, _, _]
  fail # マッチしない
in [1, x, y]
  puts "x: #{x}, y: #{y}" # => x: 2, y: 3
end

# * を使って残りとマッチできる
puts "asterisk pattern"
case [1, 2, 3]
in [x, *y]
  puts "x: #{x}, y: #{y}" # => x: 1, y: [2, 3]
end

# 1行でinを使ってパターンマッチできる
puts "oneline pattern"
[1, 2, 3] in [x, _, _]
puts "x: #{x}" # => x: 1

# destructを定義してればなんでもマッチできる
puts "deconstruct with method"
class Tester
  def self.deconstruct
    [1, 2, 3]
  end
end
case Tester
in [_, x, _]
  puts "x: #{x}" # => x: 2
end
