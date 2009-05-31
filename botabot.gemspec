# coding: utf-8

begin
  require "rubygems/specification"
rescue SecurityError
  # http://gems.github.com
end

VERSION  = "0.0.2"
SPECIFICATION = ::Gem::Specification.new do |s|
  s.name = "botabot"
  s.version = VERSION
  s.authors = ["Jakub Šťastný aka Botanicus"]
  s.homepage = "http://github.com/botanicus/botabot"
  s.summary = "BotaBot is bot for jabber (XMPP protocol), especialy for MUC (multi user chat). It can interact with users, save history."
  s.description = "" # TODO: long description
  s.cert_chain = nil
  s.email = ["knava.bestvinensis", "gmail.com"].join("@")
  s.files = Dir.glob("**/*") - Dir.glob("pkg/*")
  s.executables = ["botabot.rb", "plugin.rb"]
  s.default_executable = "botabot.rb"
  s.add_dependency "xmpp4r"
  s.require_paths = ["lib"]
  # s.required_ruby_version = ::Gem::Requirement.new(">= 1.9.1")
  s.rubyforge_project = "botabot"
end
