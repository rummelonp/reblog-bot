
require 'singleton'
require 'yaml'

module ReblogBot
  class Environment
    include Singleton

    def root
      @root ||= File.expand_path('../../..', __FILE__)
    end

    def config_path
      @config_path ||= File.join(root, 'config/config.yml')
    end

    def data_root
      @data_root ||= File.join(root, 'data')
    end

    def logs_root
      @logs_root ||= File.join(root, 'logs')
    end

    def config(reload = false)
      if reload
        @config = load_config
      else
        @config ||= load_config
      end
    end

    def load_config
      load_yaml(config_path)
    end

    def load_data(data_name)
      load_yaml(File.join(data_root, data_name))
    end

    def dump_data(data_name, data)
      dump_yaml(File.join(data_root, data_name), data)
    end

    def load_yaml(path)
      YAML.load_file(path)
    rescue
      {}
    end

    def dump_yaml(path, data)
      YAML.dump(data, File.open(path, 'w'))
    end
  end
end
