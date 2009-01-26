# Cealled when somone join the room
callback :join do |muc, time, nick|
  muc.say("#{nick}: no to je dost, ze jdes!")
end