# -*- coding: utf-8 -*-

require 'pry'
require 'thor/group'

module ReblogBot
  module Tasks
    class Console < Thor::Group
      Tasks.register :console, self

      include Actions

      def self.banner
        'reblog_bot.rb console'
      end

      desc 'start console'

      def console
        Pry.start(self)
      end
    end
  end
end

