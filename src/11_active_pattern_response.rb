require 'active_pattern'

puts "extract from response with active pattern"

ok_response = {
  status: "ok",
  body: {
    id: 1,
    url: "https://api.github.com/repos/octocat/Hello-World/pulls/1347",
    user: {
      login: "octocat",
      id: 2,
      type: "User",
      site_admin: false
    },
    assignee: {
      login: "kokuyou",
      id: 3,
      type: "User",
      site_admin: true
    }
  }
}
ng_response = {
  status: "ng",
  message: "Oops, something went wrong!"
}

module Response
  extend ActivePattern::Context[Hash]
  OK = pattern { self[:status] == 'ok' && [self[:body]] }
  NG = pattern { self[:status] == 'ng' && [self[:message]] }
end

def print_response(response)
  case response
  in Response::OK[body]
    puts 'OK! body: ' + body.to_s
  in Response::NG[message]
    puts 'NG! message: ' + message
  end
end

puts "\n=== print ok"
print_response(ok_response)
puts "\n=== print ng"
print_response(ng_response)

module PullRequest
  extend ActivePattern::Context[Hash]
  Users = pattern { {
    owner: dig(:body, :user, :login),
    assignee: dig(:body, :assignee, :login) }
  }
end

puts "\n=== print owner and assignee"
ok_response in PullRequest::Users(owner: owner, assignee: assignee)
puts "owner: #{owner}, assignee: #{assignee}"
