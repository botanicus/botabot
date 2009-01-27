plugin :help, "nápověda pro dostupné pluginy" do |*args|
  if (command = args.first)
    plugin = BotaBot::Plugins[command.to_sym]
    muc.say("#{command}: #{plugin.desc}")
  else
    muc.say("=== Help ===")
    BotaBot::Plugins.all.each do |name, plugin|
      muc.say("#{name}: #{plugin.desc}")
    end
  end
end
