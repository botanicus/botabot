plugin :help, "nápověda pro dostupné pluginy" do |bot, muc|
  muc.say("=== Help ===")
  BotaBot::Plugins.all.each do |name, plugin|
    muc.say("#{name}: #{plugin.desc}")
  end
end
