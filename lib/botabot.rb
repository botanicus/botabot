require "botabot/bot"
require "botabot/config"
require "botabot/kernel"
require "botabot/exceptions"
require "botabot/logger"
require "botabot/muc"
require "botabot/plugins"

module BotaBot
  VERSION = "0.0.1"
  def self.root
    File.dirname(File.dirname(__FILE__))
  end
  
  def self.logger
    BotaBot::Logger.instance
  end

  def self.config
    BotaBot::Config.instance
  end

  def self.bot
    BotaBot::Bot.instance
  end
  
  def self.init
    bot.init(config.jid, config.password)
    bot.join(config.muc)
    Plugins.load
    return bot
  end
  
  def self.reload
    Dir["#{BotaBot.root}/lib/botabot/*.rb"].each do |library|
      load(library)
    end
  end
  
  def self.run
    self.init
    loop do
      sleep 1
    end
  end
end
