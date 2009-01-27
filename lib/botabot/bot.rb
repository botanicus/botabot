require "xmpp4r"
require "singleton"
require "botabot/exceptions"

module BotaBot
  class Bot
    include Singleton
    attr_accessor :mucs
    def init(jid, password)
      @client = Jabber::Client.new(Jabber::JID.new(jid))
      @client.connect
      @client.auth(password)
      @mucs = Array.new
      BotaBot.logger.debug("Logged in as #{jid}")
    end

    # TODO: statuses (from configuration)
    def set_status
      @status = Jabber::Presence.new
      @status.set_show(:chat).set_status("Some status")
      @bot.send(status)
    end
    
    def join(room)
      BotaBot.logger.debug("Trying to join MUC '#{room}'")
      muc = MUC.new(@client)
      jid = Jabber::JID.new("#{room}/botabot")
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
