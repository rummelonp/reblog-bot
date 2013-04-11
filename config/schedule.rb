# -*- coding: utf-8 -*-

root = File.dirname(__FILE__) + '/..'
$:.unshift File.join(root, 'lib')

require 'reblog_bot'

job_type :reblog_bot, 'cd :path && ./reblog_bot.rb :task :output'

@config = ReblogBot::Environment.instance.config
@config[:accounts].each do |name, account|
  log_name = "log/#{name}.log"

  every 12.hours do
    reblog_bot "followback #{name}", :output => log_name
  end

  next unless account[:every]
  every instance_eval(account[:every]) do
    reblog_bot "reblog #{name}", :output => log_name
  end
end
