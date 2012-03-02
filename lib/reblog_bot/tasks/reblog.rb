# -*- coding: utf-8 -*-

module ReblogBot
  module Tasks
    class Reblog < Thor::Group
      Tasks.add_task :reblog, self

      include ReblogBot::Actions
      include ReblogBot::Helpers

      argument :name, :desc => 'Account name'

      require_arguments!

      def initialize(*args)
        super
        @config = ReblogBot::ConfigLoader.load
        @account = @config.accounts[name]
        @client = client @config, @account

        @reblogged_log_name = "data/#{name}.reblogged.yml"
        begin
          @reblogged = YAML.load_file @reblogged_log_name
        rescue
          @reblogged = []
        end

        @filters = []
        Filters.filters.each do |key, filter|
          if @account.key? key
            @filters << filter.new(@account[key])
          end
        end
      end

      def from
        following = @client.following
        user = following.blogs[(following.blogs.size * rand).to_i]
        @base_hostname = "#{user.name}.tumblr.com"
        @info = @client.info @base_hostname
      end

      def post
        offset = (@info.blog.posts * rand).to_i
        data = @client.posts(@base_hostname, offset: offset)
        @post = data.posts.select {|p|
          @filters.all? {|f| f.match p}
        }.select{|p|
          not @reblogged.include? p.reblog_key
        }.first
      end

      def reblog
        return unless @post
        begin
          say "from: #{@base_hostname}"
          say "url: #{@post.post_url}"
          say "type: #{@post.type}"
          say "note: #{@post.note_count}"
          say "date: #{@post.date}"
          @client.reblog_post "#{name}.tumblr.com", {
            id: @post.id,
            reblog_key: @post.reblog_key,
            comment: Date.parse(@post.date)
          }
          @reblogged << @post.reblog_key
        rescue
          shell.error $!.inspect
        end
      end

      def teardown
        YAML.dump(@reblogged, File.open(@reblogged_log_name, 'w'))
      end
    end
  end
end
