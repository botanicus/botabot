require "xmpp4r/muc/helper/mucbrowser"

plugin :rooms, "dostupné MUC na tomto nebo zadaném serveru" do #|jid|
  browser = Jabber::MUC::MUCBrowser.new(Jabber::Stream.new)
  browser.muc_rooms(config.room).each do |jid, name|
    reply("#{name}: #{jid}")
  end
  #browser.muc_rooms('conference.jabber.org').each { |jid, name| ... }
  #browser.muc_name(jid) # info about room
end
