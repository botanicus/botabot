# dice.rb -- throws a dice for you
# Copyright (C) 2009 Miroslav Hradílek
# Usage: .dice [number of sides]

plugin :dice, "throws a dice for you" do |*args|
  if args.empty?
    muc.say( (1 + rand(6)).to_s )
  elsif args.include?("help")
    muc.say("Usage: .dice [number of sides]")
  else
    muc.say((1 + rand( args[0].to_i )).to_s)
  end
end
