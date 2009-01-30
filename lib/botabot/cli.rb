require "botabot"
require "botabot/config"

module BotaBot
  class CLI
    def initialize(argv)
      @argv = argv
    end

    def run
      self.help if @argv.length > 2
      profile = @argv.length.eql?(2) || (@argv.length.eql?(1) && @argv.first.match(/^\w/)) ? @argv.shift : "default"
      case @argv.first
      when "-i", "--interactive"
        self.interactive(profile)
      when "-d", "--daemon"
        self.daemonize(profile)
      when "-m", "--migrate"
        self.migrate
      when nil
        BotaBot.run(profile)
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

    def interactive(profile)
      BotaBot.init(profile)
      require "botabot/console"
      ARGV.clear # otherwise IRB will raise exceptions, he thoughts it's his own ARGV
      # TODO: what with logger's debug messages?
      ::IRB.start(__FILE__)
    end

    def migrate
      BotaBot.migrate
    end

    def daemonize(profile)
      BotaBot.init(profile)
      raise NotImplementedError
    end
  end
end
