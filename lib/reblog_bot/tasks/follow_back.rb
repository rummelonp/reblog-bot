# -*- coding: utf-8 -*-

module ReblogBot
  module Tasks
    class FollowBack < Thor::Group
      Tasks.add_task :followback, self

      include ReblogBot::Actions
      include ReblogBot::Helpers

      argument :name, :desc => 'Account name'

      require_arguments!

      def initialize(*args)
        super
        @config = ReblogBot::ConfigLoader.load
        @account = @config.accounts[name]
        @client = client @config, @account
      end

      def followers
        @followers = @client.followers "#{name}.tumblr.com"
      end

      def following
        @following = @client.following
      end

      def follow_back
        (@followers.users - @following.blogs).each do |u|
          say "follow: #{u.url}"
          @client.follow url: u.url
        end
      end

      def unfollow
        (@following.blogs - @followers.users).each do |u|
          say "unfollow: #{u.url}"
          @client.unfollow url: u.url
        end
      end
    end
  end
end
