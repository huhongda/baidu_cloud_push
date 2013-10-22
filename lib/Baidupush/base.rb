#encoding:utf-8
require 'yaml'
require "#{File.dirname(__FILE__)}/base_error"
require 'digest'
require 'uri'
require "net/http"
require "net/https"
require 'cgi'

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

    def self.get_sign(params,secertkey,url_method,url)
      str = "#{url_method}#{url}"
      _params = {}
      keys = params.keys
      keys = keys.sort
      keys.each do |key|
        str += "#{key}=#{params[key]}"
      end
      str += "#{secertkey}"
      #p "**STR:#{str}"
      str = CGI::escape(str)
      #p "**Str: #{str}"
      sign = Digest::MD5.hexdigest(str)
      sign
    end

    def self.https_get(url,args)
      uri = URI.parse(url)
      uri.query = URI.encode_www_form(args)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = false
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(uri.request_uri)
      time_start = Time.now.to_i
      response = http.request(request)
      time_end = Time.now.to_i
      response.body
    end

    def self.http_post(url,args)
      uri = URI.parse(url)
      https=Net::HTTP.new(uri.host,uri.port)
      req = Net::HTTP::Post.new(uri.path)
      req.set_form_data(args)
      time_start = Time.now.to_i
      p "req : #{req.body}"
      res = https.request(req)
      time_end = Time.now.to_i
      res.body
    end


    def self.http_get(url,args)
      uri = URI.parse(url)
      uri.query = URI.encode_www_form(args)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      time_start = Time.now.to_i
      response = http.request(request)
      time_end = Time.now.to_i
      response.body
    end

    def self.https_post(url,args)
      uri = URI.parse(url)
      https=Net::HTTP.new(uri.host,uri.port)
      https.use_ssl=true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE
      req = Net::HTTP::Post.new(uri.path)
      req.set_form_data(args)
      res = https.request(req)
      res.body
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