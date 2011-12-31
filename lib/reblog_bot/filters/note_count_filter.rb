# -*- coding: utf-8 -*-

module ReblogBot
  module Filters
    class NoteCountFilter
      Filters.add_filter :note_count, self

      def initialize(options = {})
        @_min = options[:min] || 0
        @_max = options[:max] || Float::INFINITY
      end

      def match(post)
        post.note_count ||= 0
        post.note_count > @_min && post.note_count < @_max
      end
    end
  end
end
