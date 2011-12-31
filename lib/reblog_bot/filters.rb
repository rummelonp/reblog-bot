# -*- coding: utf-8 -*-

module ReblogBot
  module Filters
    class << self
      def filters
        @_filters ||= {}
      end

      def add_filter(name, filter)
        filters[name] = filter
      end
    end

    Dir[File.dirname(__FILE__) + '/filters/*.rb'].each {|f| require f}
  end
end
