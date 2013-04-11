# -*- coding: utf-8 -*-

require 'reblog_bot/environment'
require 'tumblife'

module ReblogBot
  module Tasks
    module Actions
      def env
        @env ||= Environment.instance
      end

      def client(account)
        account = account.to_sym
        Tumblife::Client.new(
          :consumer_key       => env.config[:consumer_key],
          :consumer_secret    => env.config[:consumer_secret],
          :oauth_token        => env.config[:accounts][account][:oauth_token],
          :oauth_token_secret => env.config[:accounts][account][:oauth_token_secret],
        )
      rescue
        raise ArgumentError, "No such account #{account}"
      end

      def now
        Time.now.strftime('[%m/%d %a] (%H:%M:%S)')
      end

      def help!
        self.class.help(shell)
        exit
      end

      def error(message)
        shell.error(message)
      end

      def error!(message)
        error(message)
        exit false
      end
    end
  end
end
