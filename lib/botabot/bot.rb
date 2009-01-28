require "xmpp4r"
require "singleton"
require "botabot/exceptions"

module BotaBot
  class Bot
    include Singleton
    attr_accessor :mucs
    attr_reader :config
    def init(config)
      @config = config
      @client = Jabber::Client.new(Jabber::JID.new("#{config.jid}/#{config.resource}"))
      @client.connect
      @client.auth(config.password)
      @mucs = Array.new
      BotaBot.logger.debug("Logged in as #{config.jid}")
      self.set_status
    rescue ClientAuthenticationFailure
      # try to register new JID for your bot if authentication failed
      @retries ||= 0
      @retries  += 1
      @client.register(config.password)
      retry unless @retries > 1
    end

    def set_status
      status = Jabber::Presence.new(:chat, config.status)

      @client.send(Jabber::Presence.new.set_type(:chat))

      #@client.send(status)
      BotaBot.logger.debug("Status set to '#{config.status}'")
    end

    # send_message("botanicus@njs.netlab.cz", "Hey bro!")
    def send_message(jid, body)
      jid = Jabber::JID.new(jid)
      # type normal: simple message; type chat: 2to2 chat window
      message = Jabber::Message::new(jid, body).set_type(:normal).set_id('1')
      @client.send(message)
    end
    
    def join(room)
      BotaBot.logger.debug("Trying to join MUC '#{room}'")
      muc = MUC.new(@client, config)
      jid = Jabber::JID.new("#{config.room}/#{config.nick}")
      muc.join(jid) # instead of just room
      BotaBot.logger.debug("Bot joined MUC '#{room}'")
      # important: we need to wait for initialization,
      # all the message events from jabber history
      # must be fired before callback registration
      sleep 1
      muc.setup_callbacks
      @mucs.push(muc)
      return muc
    end
    
    def run
      Thread.stop
    end
  end
end
