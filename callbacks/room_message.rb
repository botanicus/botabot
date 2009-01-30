# Called when message from room comes.
# Example: Astro has joined this session
callback :room_message do |*args|
  BotaBot.logger.debug("Callback room message called.")
end
