require "singleton"

module BotaBot
  class Logger
    include Singleton
    def debug(message)
      STDERR.puts("~ #{message}")
    end

    def error(message)
      STDERR.puts("[ERROR] #{message}")
    end
  end
end
