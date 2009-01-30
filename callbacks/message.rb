# Called when someone write a message
callback :message do |*args|
  BotaBot.logger.debug("Callback message called.")
end
