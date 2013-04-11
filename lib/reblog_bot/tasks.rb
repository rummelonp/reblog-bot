# -*- coding: utf-8 -*-

module ReblogBot
  module Tasks
    def self.mappings
      @mappings ||= {}
    end

    def self.register(task_name, klass)
      mappings[task_name.to_sym] = klass
    end
  end
end

Dir[File.dirname(__FILE__) + '/tasks/*.rb'].each do |file|
  require file
end
