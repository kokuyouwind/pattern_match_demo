puts 'abstract syntax tree'

def print_tree(node, indent = 0)
  print '| ' * indent
  case [node&.type, node&.children]
  in [:SCOPE, [_, _, n1]]
    puts 'scope'
    print_tree(n1, indent + 1)
  in [:OPCALL, [n1, op, n2]]
    puts op.to_s
    print_tree(n1, indent + 1)
    print_tree(n2, indent + 1)
  in [:LIST, [h, t]]
    puts 'cons'
    print_tree(h, indent + 1)
    print_tree(t, indent + 1)
  in [:LIT, [lit]]
    puts lit.to_s
  in [nil, _]
    puts 'nil'
  end
end

# output:
#
# scope
# | +
# | | 1
# | | cons
# | | | 2
# | | | nil
puts "tree of '1 + 2'"
print_tree(RubyVM::AbstractSyntaxTree.parse('1 + 2'))

# output:
#
# scope
# | -
# | | +
# | | | 1
# | | | cons
# | | | | *
# | | | | | 2
# | | | | | cons
# | | | | | | 3
# | | | | | | nil
# | | | | nil
# | | cons
# | | | 4
# | | | nil
puts ''
puts "tree of '1 + 2 * 3 - 4'"
print_tree(RubyVM::AbstractSyntaxTree.parse('1 + 2 * 3 - 4'))
