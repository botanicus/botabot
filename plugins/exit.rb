# TODO: aliases (exit, die ..)
plugin :exit, "opusť MUC" do |bot, muc|
  muc.say("Tak ja teda padam ...")
  muc.exit
end
