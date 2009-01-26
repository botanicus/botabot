# bot.config, bot.muc
plugin :about, "informace o botovi" do |bot, muc, *args|
  if args.empty?
    muc.say("Jsem velký botabot ve verzi #{BotaBot::VERSION}, tak tu moc nemachruj!")
  elsif args.include?("news")
    muc.say("Tak na tomhle místě bych ti měl říct jak hustý novinky obsahuje moje poslední verze, ale protože páníček je děsná lemra a ještě tuhle fíčury neimplementoval, tak máš smůlu.")
  else
    muc.say("O co se to snažíš? Jestli chceš novinky, tak .about news ty lamo!")
  end
end
