#!/usr/bin/env ruby1.8

$:.push(File.dirname(__FILE__) + "/../lib")

require "rubygems"
require "botabot/cli"

BotaBot::CLI.new(ARGV).run
