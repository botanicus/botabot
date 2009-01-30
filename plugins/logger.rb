class LoggerMessage
  include DataMapper::Resource
  property :id, Serial
  property :body, String
  property :nick, String
  property :time, DateTime
  belongs_to :user

  before :save do
    self.user = User.get(nick) || User.create(:nick => nick)
    self.user.msg_count += 1
    self.time = DateTime.now
  end

  after :save do
    BotaBot.logger.debug("DataMapper: new logger message saved")
  end
end

class User
  include DataMapper::Resource
  property :nick, String, :key => true
  property :msg_count, Integer, :default => 0
  has n, :messages, :class => "LoggerMessage"

  after :save do
    BotaBot.logger.debug("DataMapper: new user saved")
  end
end

plugin :log, "zobraz log místnosti (PM)" do |*args|
  limit = args.first || 100
  LoggerMessage.all(:order => [:time], :limit => limit)
end
