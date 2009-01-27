require "yaml"
require "singleton"

module BotaBot
  class Config
    include Singleton
    def initialize
      file = "#{BotaBot.root}/config/settings.yml"
      @settings = YAML::load_file(file)
    end
    
    def jid
      @settings["account"]["jid"]
    end
    
    def password
      @settings["account"]["password"]
    end
    
    def muc(profile = "default")
      @settings["profiles"][profile]
    end
  end
end
