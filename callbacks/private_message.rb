# Called when bot get private message
callback :private_message do |*args|
  BotaBot.logger.debug("Callback PM called.")
end
