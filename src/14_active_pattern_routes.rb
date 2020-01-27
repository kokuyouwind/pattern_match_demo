require 'active_pattern'

puts 'routing with active pattern'

module Route
  extend ActivePattern::Context[String]

  Root = pattern { self == '/' }
  Users = pattern { self == '/users/' }
  User = pattern { %r|^/users/([0-9]+)/$|.match(self)&.captures }
  UserPosts = pattern { %r|^/users/([0-9]+)/posts/$|.match(self)&.captures }
  UserPost = pattern { %r|^/users/([0-9]+)/posts/([0-9]+)/$|.match(self)&.captures }
end

def parse_route(path)
  case path
  in Route::Root
    puts 'root path'
  in Route::Users
    puts 'users path'
  in Route::User[uid]
    puts "user path(user_id: #{uid})"
  in Route::UserPosts[uid]
    puts "user posts path(user_id: #{uid})"
  in Route::UserPost[uid, pid]
    puts "user post path(user_id: #{uid}, post_id: #{pid})"
  else
    puts 'unknown path'
  end
end

parse_route('/') #=> root path
parse_route('/users/') #=> users path
parse_route('/users/765/') #=> user path(user_id: 765)
parse_route('/users/765/posts/') #=> user posts path(user_id: 765)
parse_route('/users/765/posts/315/') #=> user post path(user_id: 765, post_id: 315)
parse_route('/users/765/315/') #=> unknown path
