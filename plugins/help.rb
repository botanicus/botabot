plugin :help, "nápověda pro dostupné pluginy" do |*args|
  if (command = args.first)
    plugin = BotaBot::Plugins[command.to_sym]
    reply("#{command}: #{plugin.desc}")
  else
    reply("=== Help ===")
    BotaBot::Plugins.all.each do |name, plugin|
      reply("#{name}: #{plugin.desc}")
    end
  end
end
