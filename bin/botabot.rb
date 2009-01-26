#!/usr/bin/env ruby

$:.push(File.dirname(__FILE__) + "/../lib")

require "rubygems"
require "botabot/cli"

BotaBot::CLI.new(ARGV).run
