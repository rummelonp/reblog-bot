# -*- coding: undecided -*-

$:.unshift File.dirname(__FILE__) + '/../lib'

require 'rubygems'
require 'bundler'
Bundler.require
require 'reblog_bot'

job_type :reblog_bot, 'cd :path && ./reblog_bot.rb :task :output'

@config = ReblogBot::ConfigLoader.load
@config.accounts.each do |name, account|
  log_name = "log/#{name}.log"

  every 12.hours do
    reblog_bot "followback #{name}", output: log_name
  end

  next unless account.every
  every instance_eval(account.every) do
    reblog_bot "reblog #{name}", output: log_name
  end
end
