require "xmpp4r/muc"

module BotaBot
  class MUC < Jabber::MUC::MUCClient
    attr_reader :config
    def initialize(client, config)
      super(client)
      @nick    = config.nick
      @config  = config
      @regexps = format_regexp
    end

    def format_regexp(format = config.format)
      format_regexp([format]) if format.is_a?(String)
      format.map do |string|
        string = Regexp.quote(string)
        string.gsub!("%c", '(\w+)')
        string.gsub!("%n", Regexp::quote(@nick))
        string
      end
    end

    def setup_callbacks
      add_message_callback do |message|
        BotaBot.logger.debug("Message: #{message.inspect}")
        BotaBot.logger.debug("From: #{message.from}")
        BotaBot.logger.debug("Body: #{message.body}")
        @regexps.each do |regexp|
          if message.body.match(/^#{regexp}(\s*(.+))?/)
            BotaBot.logger.debug("Pattern '#{regexp}' matched.")
            name = $1.to_sym
            args = ($3.split(/\s+/) rescue Array.new)
            Plugins[name].run(self, message, *args)
            break # eval just for first matching regexp
          end
        end
      end
      
      add_join_callback do |message|
        BotaBot.logger.debug("User #{message.from} join the room.")
        BotaBot.logger.debug("Message: #{message.inspect}")
      end
      
      add_leave_callback do |message|
        BotaBot.logger.debug("User #{message.from} leave the room.")
        BotaBot.logger.debug("Message: #{message.inspect}")
      end
      
      # TODO: works it?
      add_presence_callback do |message|
        BotaBot.logger.debug("Message: #{message.inspect}")
        BotaBot.logger.debug("From: #{message.from}")
        BotaBot.logger.debug("Body: #{message.body}")
      end
      
      # TODO: at_exit ... close SQLite connection etc

      add_private_message_callback do |message|
        BotaBot.logger.debug("PM: #{message.inspect}")
        BotaBot.logger.debug("From: #{message.from}")
        BotaBot.logger.debug("Body: #{message.body}")
        args = message.body.split(/\s+/)
        Plugins[args.shift.to_sym].run(self, message, *args)
      end
    end

    # say(what, nickname)
    def say(what, to = nil)
      message = Jabber::Message.new(self, what)
      self.send(message, to)
    end
  end
end
