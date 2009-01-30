# Called when someone set the subject
callback :subject do |*args|
  BotaBot.logger.debug("Callback subject called.")
end
