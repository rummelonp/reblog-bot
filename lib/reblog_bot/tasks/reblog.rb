# -*- coding: utf-8 -*-

require 'reblog_bot/tasks/actions'
require 'thor/group'

module ReblogBot
  module Tasks
    class Reblog < Thor::Group
      Tasks.register :reblog, self

      include Actions

      def self.banner
        'reblog_bot.rb reblog [account name]'
      end

      desc 'random reblog by configuration'

      argument :name, :desc => 'Account name', :optional => true

      def setup
        help! unless name
        @config = env.config[:accounts][name.to_sym]
        @client = client(name)

        @reblogged_log_name = "#{name}.reblogged.yml"
        @reblogged = env.load_data(@reblogged_log_name)

        @filters = []
        Filters.mappings.each do |key, filter|
          @filters << filter.new(@config[key]) if @config.key?(key)
        end
      rescue
        error! $!.message
      end

      def from
        following = @client.following_all
        user = following[(following.size * rand).to_i]
        @base_hostname = "#{user.name}.tumblr.com"
        @blog_info = @client.blog_info(@base_hostname)
      end

      def post
        offset = (@blog_info.blog.posts * rand).to_i
        data = @client.posts(@base_hostname, :offset => offset)
        @post = data.posts.select {|p|
          @filters.all? { |f| f.match(p) }
        }.select{|p|
          !@reblogged.include?(p.reblog_key)
        }.first
      end

      def reblog
        return unless @post
        begin
          say "#{now} from: #{@base_hostname}"
          say "#{now} url: #{@post.post_url}"
          say "#{now} type: #{@post.type}"
          say "#{now} note: #{@post.note_count}"
          say "#{now} date: #{@post.date}"
          @client.reblog(
            "#{name}.tumblr.com",
            @post.id,
            @post.reblog_key,
            Date.parse(@post.date),
          )
          @reblogged << @post.reblog_key
        rescue
          error $!.inspect
        end
      end

      def teardown
        env.dump_data(@reblogged_log_name, @reblogged)
      end
    end
  end
end
