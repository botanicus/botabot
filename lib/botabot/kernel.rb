require "botabot/plugins"
require "botabot/callbacks"

module Kernel
  def plugin(name, desc = nil, &block)
    if name.is_a?(Hash)
      BotaBot::Plugins[name.key] = block
      BotaBot::Plugins[name.key].roles = name.values
    elsif name.is_a?(Symbol)
      BotaBot::Plugins[name] = {:desc => desc, :block => block}
    end
  end
  
  # callback :self_leave do |muc|
  #   muc.say("Seru na vas, ja jdu domu!")
  # end
  def callback(name, &block)
    BotaBot::Callbacks[name] = block
  end
end
