# coin.rb -- throws a coin for you
# Copyright (C) 2009 Miroslav Hradílek
# Usage: .coin [tails | heads]

plugin :coin, "throws a coin for you" do |*args|
  states = ["heads", "tails"]     # names of heads and tails
  if args.empty?
  # one player game
    if (1 + rand(2)) == 1
      reply(states[0])
    else
      reply(states[1])
    end
  elsif args.length == 1 and states.include?(args[0])
  # two players game
    $players = [] unless $players # make players array in case it isn't exist
    $choice  = [] unless $choice  # make choice array in case it isn't exist
    player = msg.from.to_s.sub(/^.+\//, "")
    unless $players.include?(player) or $choice.include?(args[0])
      $players.push(player)
      $choice.push(args[0])
    else
      reply("You can't go twice.")           if $players.include?(player)
      reply("You can't pick the same side.") if $choice.include?(args[0])
    end
#    $players.push(player) unless $players.include?(player)
    if $players.length >= 2
    # we have enough players, throw a coin!
      states.reverse! if (1 + rand(2)) == 1
      reply($players[0] + ": " + states[0] + ", " + $players[1] + ": " + states[1])
      $players = []               # clear players list for another game
      $choice  = []               # clear choice list for another game
    end
  else
    reply("Usage: .coin [tails | heads]")
  end
end
