#encoding:utf-8
require 'yaml'
require 'base_error'

module Baidupush
  class Base
    # To change this template use File | Settings | File Templates.

    # 获取配置信息
    # Example:
    #   >> Base.load_config
    #   => {"name"=>"测试推送","secret_key"=>"","api_key"=>""}
    def self.load_config
      path = Rails.root.join("config",'baidu_cloud_push.yml')
      config = YAML.load(path)
      DEFAULT_CONFIG.keys.each do |key|
        unless config[key.to_s]
          raise BaseError.new(BaseError.missing_parameters,"缺少参数：#{key.to_s}")
        end
      end
    end

    private

    #初始化百度推送配置
    DEFAULT_CONFIG = {
        :name => "",
        :secret_key => "",
        :api_key => "",
    }

  end
end