require "xmpp4r/muc/x/mucuserinvite"

plugin :invite, "pozvi někoho do chatu" do |jid|
  invitation = Jabber::MUC::XMUCUserInvite.new(jid)
  invitation.reason = "Byl jsi pozván uživatelem #{nick} do #{muc}"
  invitation.from   = nick
end
