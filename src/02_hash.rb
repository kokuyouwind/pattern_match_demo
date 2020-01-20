# ハッシュのキーごとにパターンマッチできる
puts "basic pattern"
case { first: "Hotaru", last: "Shiragiku" }
in { first: "Kako", last: _ }
  fail # マッチしない
in { first: "Hotaru", last: name }
  puts "name: #{name}" # => name: Shiragiku
end

# 1行でinを使ってマッチできる
# ** を使って残りとマッチできる
puts "one line pattern and asterisk pattern"
{ first: "Hotaru", last: "Shiragiku" } in { first: first, **rest }
puts "first: #{first}, rest: #{rest}" # => first: Hotaru, rest: {:last=>"Shiragiku"}

# deconstruct_keysを定義すれば何でもマッチできる
# 引数には「マッチしようとしたキー名」が配列で渡る
puts "deconstruct_keys with method"
class Tester
  def self.deconstruct_keys(_)
    { first: "Hotaru", last: "Shiragiku" }
  end
end
case Tester
in { first: "Hotaru", last: name }
  puts "name: #{name}" # => name: Shiragiku
end
