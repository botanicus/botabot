require "botabot/kernel"
require "botabot/role"
require "botabot/roles"

module BotaBot
  # TODO: merge PluginInstance and Plugin classes
  class PluginInstance
    attr_reader :bot, :muc, :msg, :nick
    def initialize(block, bot, muc, msg)
      self.register(block)
      @bot  = bot
      @muc  = muc
      @msg  = msg
      @nick = msg.from
    end

    def register(block)
      self.class.send(:define_method, :run, &block)
    end
  end

  class Plugin
    attr_writer :roles
    attr_reader :name, :desc, :rights
    def initialize(client, name, desc, block)
      @client = client
      @name   = name
      @desc   = desc
      @block  = block
    end
    
    #def roles
    #  @roles or Roles.all
    #end
    def has_rights?(nick)
      return true # FIXME
      Roles[nick].rights >= self.rights
    end

    def run(muc, message, *args)
      BotaBot.logger.debug("Called plugin #{@name} with args #{args.inspect}")
      PluginInstance.new(@block, @client, muc, message).run(*args) if self.has_rights?(message.from)
    rescue
      BotaBot.logger.error("Exception: #$!")
      BotaBot.logger.error("Details: #{$!.backtrace.join("\n")}")
    end
  end
end
