# Called when someone leave the room
callback :leave do |*args|
  BotaBot.logger.debug("Callback leave called.")
end
