require "yaml"
require "singleton"
require "ostruct"

module BotaBot
  class Config
    include Singleton
    def initialize
      file = "#{BotaBot.root}/config/settings.yml"
      @settings = YAML::load_file(file)
    end
    
    def nick
      @settings["account"]["nick"]
    end
    
    def jid
      @settings["account"]["jid"]
    end
    
    def password
      @settings["account"]["password"]
    end
    
    def profile
      default = @settings["profiles"]["default"]
      current = @settings["profiles"][@profile]
      OpenStruct.new(default.merge(current))
    end

    def set_profile(profile = "default")
      # TODO: check if profile exists
      @profile = profile
    end
  end
end
