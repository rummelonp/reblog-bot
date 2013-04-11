# -*- coding: utf-8 -*-

module ReblogBot
  module Filters
    class TypeFilter
      Filters.register :type, self

      TYPES = %w{photo quote text link video audio}.freeze

      def initialize(types = TYPES)
        @types = types.map(&:to_s).select{|t| TYPES.include? t}
      end

      def match(post)
        @types.include? post.type
      end
    end
  end
end
