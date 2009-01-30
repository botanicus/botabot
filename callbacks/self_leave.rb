# Called when bot leave the room
callback :self_leave do |*args|
  BotaBot.logger.debug("Callback room message called.")
end
