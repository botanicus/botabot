#!/usr/bin/env ruby1.8

$:.push(File.dirname(__FILE__) + "/../lib")

# TODO: base = File.symlink?(__FILE__) ? File.readlink(__FILE__) : __FILE__
require "rubygems"
require "botabot/cli"

BotaBot::CLI.new(ARGV).run
