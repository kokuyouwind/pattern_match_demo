require 'active_pattern'

puts 'eval ast with active pattern'

module Node
  extend ActivePattern::Context[RubyVM::AbstractSyntaxTree::Node]

  Scope = pattern { type == :SCOPE && children }
  OpCall = pattern { type == :OPCALL && children }
  List = pattern { type == :LIST && children }
  Literal = pattern { type == :LIT && children }

  PlusOp = pattern { self in OpCall(x, :+, List(y, nil)); [x, y] }
  MinusOp = pattern { self in OpCall(x, :-, List(y, nil)); [x, y] }
  MulOp = pattern { self in OpCall(x, :*, List(y, nil)); [x, y] }
  DivOp = pattern { self in OpCall(x, :/, List(y, nil)); [x, y] }
end

def eval_tree(tree)
  case tree
  in Node::Scope[_, _, n1]
    eval_tree(n1)
  in Node::Literal[n]
    n
  in Node::PlusOp[l, r]
    eval_tree(l) + eval_tree(r)
  in Node::MinusOp[l, r]
    eval_tree(l) - eval_tree(r)
  in Node::MulOp[l, r]
    eval_tree(l) * eval_tree(r)
  in Node::DivOp[l, r]
    eval_tree(l) / eval_tree(r)
  end
end

puts 'eval of 1 + 2'
puts eval_tree(RubyVM::AbstractSyntaxTree.parse('1 + 2')) # => 3
puts 'eval of 1 + 2 * 3 - 4 / 2'
puts eval_tree(RubyVM::AbstractSyntaxTree.parse('1 + 2 * 3 - 4 / 2')) # => 5
