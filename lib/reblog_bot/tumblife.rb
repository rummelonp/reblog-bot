# -*- coding: utf-8 -*-

require 'tumblife'

module Tumblife
  class Client
    def following_all
      count = 0
      blogs = []
      loop do
        data = following(offset = count)
        blogs = (blogs + data.blogs).uniq
        break if blogs.size >= data.total_blogs
        break if blogs.size == count
        count = blogs.size
      end
      blogs
    end

    def followers_all(blog)
      count = 0
      users = []
      loop do
        data = followers(blog, :offset => count)
        users = (users + data.users).uniq
        break if users.size >= data.total_users
        break if users.size == count
        count = users.size
      end
      users
    end
  end
end
