# say.rb -- talks for you
# Copyright (C) 2009 Miroslav Hradílek
# Usage: .say <message>

plugin :say, "talks for you" do |*args|
  if args.empty? or args.include?("help")
    reply("Usage: .say <message>")
  else
    reply(msg.body.sub(/^\.say\s/, ""))
  end
end
