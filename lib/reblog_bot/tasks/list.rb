# -*- coding: utf-8 -*-

require 'thor/group'

module ReblogBot
  module Tasks
    class List < Thor::Group
      Tasks.register :list, self

      include Actions

      def self.banner
        'reblog_bot.rb list'
      end

      desc 'show account list'

      def setup
        @accounts = env.config[:accounts].keys
      end

      def list
        say @accounts.join("\n")
        say "(#{@accounts.size} accounts)"
      end
    end
  end
end

