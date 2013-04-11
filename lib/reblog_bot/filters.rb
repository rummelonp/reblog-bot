# -*- coding: utf-8 -*-

module ReblogBot
  module Filters
    def self.mappings
      @mappings ||= {}
    end

    def self.register(filter_name, klass)
      mappings[filter_name.to_sym] = klass
    end
  end
end

Dir[File.dirname(__FILE__) + '/filters/*.rb'].each do |file|
  require file
end
