require 'active_pattern'

Video = Struct.new(:type, :status)

module Presenter
  extend ActivePattern::Context[Video]

  Type = pattern do
    case self.type
    in :official; ['公式']
    in :user; ['ユーザ']
    end
  end

  Status = pattern do
    case self.status
    in :prepare; ['準備中']
    in :onair; ['放送中']
    in :closed; ['放送済み']
    end
  end

  All = pattern { self in Type[type]; self in Status[status]; { type: type, status: status } }
end

v1 = Video.new(:official, :prepare)
v1 in Presenter::Type[type]
v1 in Presenter::Status[status]
puts "#{type}番組 #{status}" #=> 公式番組 準備中

v2 = Video.new(:user, :onair)
v2 in Presenter::All(type: type, status: status)
puts "#{type}番組 #{status}" #=> ユーザ番組 放送中

