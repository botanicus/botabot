require "botabot/plugin"

module BotaBot
  module Plugins
    def self.[](name)
      @plugins ||= Hash.new
      return @plugins[name] || @plugins[:help]
    end
    
    def self.[]=(name, block)
      @plugins ||= Hash.new
      @plugins[name] = Plugin.new(BotaBot.bot, name, block)
    end
    
    # load and reload plugins
    def self.load
      Dir["#{BotaBot.root}/plugins/*.rb"].each do |plugin|
        begin
          Kernel.load(plugin)
        rescue
          BotaBot.logger.error("Failed to load plugin #{plugin}: #{$!}")
          next
        end
      end
      BotaBot.logger.debug("Available plugins: #{@plugins.keys.inspect}")
    end
  end
end
