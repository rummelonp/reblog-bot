# -*- coding: utf-8 -*-

module ReblogBot
  module Filters
    class TypeFilter
      Filters.add_filter :type, self

      TYPES = %w{photo quote text link video audio}.freeze

      def initialize(types = TYPES)
        @_types = types.map(&:to_s).select{|t| types.include? t}
      end

      def match(post)
        @_types.include? post.type
      end
    end
  end
end
