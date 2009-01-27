# say.rb -- talks for you
# Copyright (C) 2009 Miroslav Hradílek
# Usage: .say <message>

plugin :say, "talks for you" do |*args|
  if args.empty? or args.include?("help")
    muc.say("Usage: .say <message>")
  else
    muc.say(msg.body.sub(/^\.say\s/, ""))
  end
end
