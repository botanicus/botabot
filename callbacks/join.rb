# Cealled when somone join the room
callback :join do |*args|
  BotaBot.logger.debug("Callback join called.")
end
