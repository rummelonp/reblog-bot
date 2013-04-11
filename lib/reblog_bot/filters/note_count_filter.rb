# -*- coding: utf-8 -*-

module ReblogBot
  module Filters
    class NoteCountFilter
      Filters.register :note_count, self

      def initialize(options = {})
        @min = options[:min] || 0
        @max = options[:max] || Float::INFINITY
      end

      def match(post)
        post.note_count ||= 0
        post.note_count > @min && post.note_count < @max
      end
    end
  end
end
