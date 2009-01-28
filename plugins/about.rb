# bot.config, bot.muc
plugin :about, "informace o botovi" do |*args|
  if args.empty?
    reply("Jsem velký botabot ve verzi #{BotaBot::VERSION}, tak tu moc nemachruj!")
  elsif args.include?("news")
    changes = YAML::load_file("CHANGELOG")
    version = (args.length > 1) ? args[1] : BotaBot::VERSION
    # TODO: what if given version does not exist?
    news = changes[version] || Array.new
    if news.empty?
      reply("Tak na tomhle místě bych ti měl říct jak hustý novinky obsahuje moje poslední verze, ale protože páníček je děsná lemra a nepíše CHANGELOG tak máš smůlu.")
    else
      reply("=== verze #{version} ===")
      news.each { |item| reply(item) }
    end
  else
    reply("O co se to snažíš? Jestli chceš novinky, tak .about news ty lamo!")
  end
end
