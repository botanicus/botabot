require "dm-core"
require "singleton"

module BotaBot
  class Storage
    include Singleton
    def init(muc)
      @repozitory = DataMapper.setup(:default, "sqlite3:///#{BotaBot.root}/storage/#{muc}.db")
    end

    def migrate
      DataMapper.auto_upgrade!
    end
  end
end
