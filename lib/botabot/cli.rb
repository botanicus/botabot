require "botabot"
require "botabot/config"

module BotaBot
  class CLI
    def initialize(argv)
      @argv = argv
    end

    def run
      self.help if @argv.length > 1
      case @argv.first
      when "-i", "--interactive"
        self.interactive
      when "-d", "--daemon"
        self.daemonize
      when nil
        BotaBot.run
      else
        self.help
      end
    end

    def help
      puts "=== Usage ==="
      puts "-i (--interactive)  run interactive session"
      puts "--d (--daemon)      run BotaBot as a daemon"
      puts "Without arguments BotaBot will run and print logger info to the screen"
    end

    def interactive
      BotaBot.init
      require "botabot/console"
      ARGV.clear # otherwise IRB will raise exceptions, he thoughts it's his own ARGV
      # TODO: what with logger's debug messages?
      ::IRB.start(__FILE__)
    end

    def daemonize
      self.start
      raise NotImplementedError
    end
  end
end
