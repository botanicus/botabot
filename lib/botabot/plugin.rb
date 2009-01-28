require "botabot/kernel"
require "botabot/role"
require "botabot/roles"

module BotaBot
  # TODO: merge PluginInstance and Plugin classes
  class PluginInstance
    attr_reader :bot, :muc, :msg, :nick, :sender, :config
    def initialize(block, bot, muc, msg)
      self.register(block)
      @bot    = bot
      @muc    = muc
      @msg    = msg
      @nick   = Jabber::JID.new(msg.from).resource
      @config = BotaBot.config
    end

    def sender
      # TODO: message from someone (not from room)
      case msg.type
      when :chat      then nick
      when :groupchat then muc
      end
    end

    # reply to room, to sender of message or to sender of PM
    def reply(message)
      # reply to person in MUC
      if sender.eql?(nick)
        BotaBot.logger.debug("Replying to '#{nick}'. Message: #{message}")
        muc.say(message, sender)
      # reply to room
      elsif sender.eql?(muc)
        BotaBot.logger.debug("Replying to room. Message: #{message}")
        muc.say(message)
      # reply to person not in MUC
      else
        raise NotImplementedError
      end
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
