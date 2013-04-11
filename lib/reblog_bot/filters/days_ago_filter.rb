# -*- coding: utf-8 -*-

module ReblogBot
  module Filters
    class DaysAgoFilter
      Filters.register :days_ago, self

      def initialize(days = 0)
        @days = days.to_i
      end

      def match(post)
        (Time.now.to_date - Date.parse(post.date)).to_i > @days
      end
    end
  end
end
