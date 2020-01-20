puts "extract from response"

response = {
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

# 全体のidと、userとassigneeのlogin nameを取り出したい
# digを使う場合
puts "use dig:"
p [response.dig(:body, :id), response.dig(:body, :user, :login), response.dig(:body, :assignee, :login)]

# パターンマッチを使う場合
puts "use pattern match"
response in { body: { id: id, user: { login: name1 }, assignee: { login: name2 } } }
p [id, name1, name2]
