# encoding: utf-8

module Baidupush
  # Your code goes here...
  module Generators
    class ConfigGenerator < ::Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      desc "Creates a baidu_cloud_push configuration file at config/baidu_push.yml"

      def generate_config
        p "Come in!"
        template 'baidu_cloud_push.yml', File.join('config', 'baidu_cloud_push.yml')
      end

    end
  end
end

