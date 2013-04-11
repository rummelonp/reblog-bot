# -*- coding: utf-8 -*-

require 'reblog_bot/tasks/actions'
require 'pry'
require 'thor/group'

module ReblogBot
  module Tasks
    class Cli < Thor::Group
      include Actions

      def self.banner
        'reblog_bot.rb [task]'
      end

      def self.desc
        tasks = "Tasks:\n"
        Tasks.mappings.each do |task_name, klass|
          tasks << "  #{klass.banner.ljust(40)} # #{klass.desc}\n"
        end
        tasks
      end

      def setup
        help! if ARGV.empty?
        @task = Tasks.mappings[ARGV.first.to_s.downcase.to_sym]
        help! unless @task
        ARGV.delete_at(0)
      end

      def boot
        @task.start(ARGV)
      end
    end
  end
end
