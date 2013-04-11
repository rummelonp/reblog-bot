# -*- coding: utf-8 -*-

require 'reblog_bot/filters'
require 'reblog_bot/tasks/actions'
require 'thor/group'

module ReblogBot
  module Tasks
    class FollowBack < Thor::Group
      Tasks.register :followback, self

      include Actions

      def self.banner
        'reblog_bot.rb followback [account name]'
      end

      desc 'follow back & unfollow users'

      argument :name, :desc => 'Account name', :optional => true

      def setup
        help! unless name
        @client = client(name)
        @following = @client.following_all.map(&:url)
        @followers = @client.followers_all("#{name}.tumblr.com").map(&:url)
      rescue
        error! $!.message
      end

      def follow_back
        (@followers - @following).each do |u|
          begin
            say "#{now} follow: #{u}"
            @client.follow(u)
          rescue
            error $!.inspect
          end
        end
      end

      def unfollow
        (@following - @followers).each do |u|
          begin
            say "#{now} unfollow: #{u}"
            @client.unfollow(u)
          rescue
            error $!.inspect
          end
        end
      end
    end
  end
end
