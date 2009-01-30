require "yaml"
require "singleton"

module BotaBot
  class Config
    include Singleton
    def initialize
      file = "#{BotaBot.root}/config/settings.yml"
      @settings = YAML::load_file(file)
    end
    
    def profile
      default = {:nick => "botabot", :format => ["!%c", "%n: ", "%n, "], :resource => "botabot-#{rand(1000)}"}
      default_profile = @settings[:default]
      current = @settings[@profile]
      profile = default.merge(default_profile).merge(current)
      #raise ArgumentError unless valid?
      return profile
    end

    def valid?
      properties = [:jid, :password, :room]
      properties.all? { |item| self.profile.key?(property) }
    end

    def set_profile(profile = :default)
      profile = profile.to_sym
      raise ArgumentError unless @settings.key?(profile)
      @profile = profile
    end

    def method_missing(property, *args)
      raise NoMethodError if block_given? or (not args.empty?)
      value = self.profile[property]
      raise NoMethodError if value.nil?
      return value
    end
  end
end
