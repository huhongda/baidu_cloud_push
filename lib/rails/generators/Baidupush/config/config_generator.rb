# encoding: utf-8

module Baidupush
  # Your code goes here...
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      desc "Creates a baidu_cloud_push configuration file at config/baidu_push.yml"

      def self.create_config_file
        template 'baidu_cloud_push.yml', File.join('config', 'baidu_cloud_push.yml')
      end

    end
  end
end

