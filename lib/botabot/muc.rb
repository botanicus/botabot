require "xmpp4r/muc"

module BotaBot
  class MUC < Jabber::MUC::MUCClient
    def initialize(client, profile)
      super(client)
      @nick    = profile.nick
      @profile = profile
      @regexps = format_regexp
    end

    def format_regexp(format = @profile.format)
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
      
      # add_join_callback do |message|
      #   puts "Join: #{message}"
      #   puts "Body: #{message.body}"
      #   puts
      # end
      # 
      # add_leave_callback do |message|
      #   puts "Leave: #{message}"
      #   puts "Body: #{message.body}"
      #   puts
      # end
      # 
      # add_presence_callback do |message|
      #   puts "Presence: #{message}"
      #   puts "Body: #{message.body}"
      #   puts
      # end
      # 
      # add_private_message_callback do |message|
      #   puts "PM: #{message}"
      #   puts "Body: #{message.body}"
      #   puts
      # end
    end

    def say(what)
      message = Jabber::Message.new(self, what)
      self.send(message)
    end
    
    # def join(room)
    #   super(Jabber::JID.new("#{room}/botabot"))
    # end
    
    # def reload_callbacks
    #   setup_callbacks
    # end
    
    # private
    # TODO: plugins can have access to callbacks
    # def setup_callbacks
      # Callbacks.each do |event, block|
      #   self.__send__(event, &block) && BotaBot.logger("Registered event #{event}")
      # end
      # add_message_callback do |time, nick, text|
      #   # next if nick.eql?("botabot")
      #   # next if time >= @join_time
      #   puts "Text: #{text.inspect}"
      #   if text.match(/^\.(\w+)/)
      #     Plugins[$1.to_sym].run(muc)
      #   else
      #     Plugins[:help].run(muc)
      #   end    
      # end
    # end
  end
end
