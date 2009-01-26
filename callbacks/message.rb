# Called when someone write a message
callback :message do |muc, time, nick, text|
  # next if nick.eql?("botabot")
  # next if time >= @join_time
  if text.match(/^\.(\w+)/)
    Plugins[$1.to_sym].run(muc)
    BotaBot.logger("Called plugin #{$1}")
  else
    Plugins[:help].run(muc)
  end
end