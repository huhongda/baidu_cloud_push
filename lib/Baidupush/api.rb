#encoding:utf-8
require "#{File.dirname(__FILE__)}/base_error"
require "#{File.dirname(__FILE__)}/base"
require 'securerandom'

module Baidupush
  class Api
    # To change this template use File | Settings | File Templates.

    HTTP_METHOD_POST = "POST"
    HTTP_METHOD_GET = "GET"

    def initialize(options={})
      options = YAML.load(File.expand_path('../config/baidu_cloud_push.yml', __FILE__)) unless options&&!File.exist?(File.expand_path('../config/baidu_cloud_push.yml', __FILE__))
      @options = _params_default(options,DEFAULT_API)
    end

    #获取secretkey
    def get_secret_key
      @options[:secret_key]
    end

    #获取apikey
    def get_api_key
      @options[:api_key]
    end

    #获取配置的应用名
    def get_push_name
      @options[:name]
    end

    #-----------------Channel相关函数---------------------------------------------------------------

    # 查询设备、应用、用户与百度Channel的绑定关系。
    # Arguments:
    #   method:	(String)	必须	 方法名，必须存在：query_bindlist。
    #   apikey:	(String)	必须	 访问令牌，明文AK，可从此值获得App的信息，配合sign中的sk做合法性身份认证
    #   user_id:	(String)	不必须	 用户标识。不超过256字节。如果存在此字段，则只返回与该用户相关的绑定关系
    #   device_type:	(String)	不必须	 百度Channel支持多种设备，各种设备的类型编号如下：
    #1：浏览器设备；
    #2：PC设备；
    #3：Andriod设备；
    #4：iOS设备；
    #5：Windows Phone设备；
    #如果存在此字段，则只返回该设备类型的绑定关系。 默认不区分设备类型。
    #
    #  start:	(Integer)	不必须 	查询起始页码，默认为0。
    #  limit:	(Integer)	不必须	一次查询条数，默认为10。
    #  timestamp: (integer)	必须 	用户发起请求时的unix时间戳。本次请求签名的有效时间为该时间戳+10分钟。
    #  sign:	(String)	必须 	调用参数签名值，与apikey成对出现。
    #  expires:	(Integer)	必须 	用户指定本次请求签名的失效时间。格式为unix时间戳形式。
    #  v:      (Integer)	不必须 	API版本号，默认使用最高版本。
    def query_bindlist(options={})
      options = _params_default(options,DEFAULT_REQUREST_BAIDU_METHOD)
      options = _params_default(options,DEFAULT_BINDLIST)
      request_server(options)
    end

    #-----------Channel相关函数----End----------------------------------------



    #---------------标签相关函数----------------------------------------------
    # 服务器端设置用户标签。当该标签不存在时，服务端将会创建该标签。特别地，当user_id被提交时，服务端将会完成用户和tag的绑定操作
    # Arguments:
    #  method:(String)	是	方法名，必须存在：set_tag。
    #  apikey:	(String)	是	访问令牌，明文AK，可从此值获得App的信息，配合sign中的sk做合法性身份认证。
    #  tag:	(String)	是	标签名，最长128字节。
    #  user_id:	(String)	否	用户标识，最长256字节。
    #  timestamp:	(Integer)	是	用户发起请求时的unix时间戳。本次请求签名的有效时间为该时间戳+10分钟。
    #  sign:	(String)	是	调用参数签名值，与apikey成对出现。
    #    详细用法，请参考：签名计算算法
    #
    #expires: (String)	否	用户指定本次请求签名的失效时间。格式为unix时间戳形式。
    #v:	(Integer)	否	API版本号，默认使用最高版本。
    def tag_set(options={})
      options = _params_default(options,DEFAULT_REQUREST_BAIDU_METHOD)
      options = _params_default(options,DEFAULT_SET_TAG)
      request_server(options)
    end


    #App Server查询应用标签。
    #Arguments:
    #  method:	(String)	是	方法名，必须存在：fetch_tag。
    #  apikey:	(String)	是	访问令牌，明文AK，可从此值获得App的信息，配合sign中的sk做合法性身份认证。
    #  name:	(String)	否	标签名称。
    #  start:	(Integer)	否	查询页码，默认为0。
    #  limit:	(Integer)	否	一次查询条数，默认为10。
    #  timestamp: (Integer)	是	用户发起请求时的unix时间戳。本次请求签名的有效时间为该时间戳+10分钟。
    #  sign:	(String)	是	调用参数签名值，与apikey成对出现。详细用法，请参考：签名计算算法
    #
    #  expires:	(Integer)	否	用户指定本次请求签名的失效时间。格式为unix时间戳形式。
    #  v:	(Integer)	否	API版本号，默认使用最高版本。
    def tag_fetch(options={})
      options = _params_default(options,DEFAULT_REQUREST_BAIDU_METHOD)
      options = _params_default(options,DEFAULT_FETCH_TAG)
      request_server(options)
    end


    #服务端删除用户标签。特别地，当user_id被提交时，服务端将只会完成解除该用户与tag绑定关系的操作。
    # Arguments:
    #  method:	(String)	是	方法名，必须存在：delete_tag。
    #  apikey:	(String)	是	访问令牌，明文AK，可从此值获得App的信息，配合sign中的sk做合法性身份认证。
    #  tag:	(String)	是	标签名，最长128字节。
    #  user_id:	(String)	否	用户标识，最长256字节。
    #  timestamp:	(Integer)	是	用户发起请求时的unix时间戳。本次请求签名的有效时间为该时间戳+10分钟。
    #  sign:	(String)	是	调用参数签名值，与apikey成对出现。详细用法，请参考：签名计算算法
    #
    #  expires	uint	否	用户指定本次请求签名的失效时间。格式为unix时间戳形式。
    #  v	uint	否	API版本号，默认使用最高版本。
    def tag_delete(options={})
      options = _params_default(options,DEFAULT_REQUREST_BAIDU_METHOD)
      options = _params_default(options,DEFAULT_DELETE_TAG)
      request_server(options)
    end

    #---------------标签相关函数---END----------------------------------------





    #---------推送相关函数-------------------------------------------


    #设置推送的设置 并返回
    #Arguments:
    #  method:	(String)	是	方法名，必须存在：push_msg。
    #  apikey:	(String)	是	访问令牌，明文AK，可从此值获得App的信息，配合sign中的sk做合法性身份认证。
    #  user_id:	(String)	否	用户标识，在Android里，channel_id + userid指定某一个特定client。不超过256字节，如果存在此字段，则只推送给此用户。
    #  push_type:	(Integer)	是	推送类型，取值范围为：1～3
    #    1：单个人，必须指定user_id 和 channel_id （指定用户的指定设备）或者user_id（指定用户的所有设备）
    #
    #    2：一群人，必须指定 tag
    #
    #    3：所有人，无需指定tag、user_id、channel_id
    #
    #  channel_id:	(Integer)	否	通道标识
    #  tag:	(String)	否	标签名称，不超过128字节
    #  device_type:	(Integer)	否	设备类型，取值范围为：1～5
    #    云推送支持多种设备，各种设备的类型编号如下：
    #
    #    1：浏览器设备；
    #
    #    2：PC设备；
    #
    #    3：Andriod设备；
    #
    #    4：iOS设备；
    #
    #    5：Windows Phone设备；
    #
    #如果存在此字段，则向指定的设备类型推送消息。 默认为android设备类型。
    def set_push_config(options={})
      push_config = _params_default(options,DEFAULT_PUSH_CONFIG)
      push_config
    end

    def push_msg_ios(options={})

    end


    #"title" : "hello" ,
    #    “description: "hello world"
    #
    #
    #    //android自定义字段
    #"custom_content": {
    #    "key1":"value1",
    #    "key2":"value2"
    #},
    #生成用于Andriod发送的消息
    # Augment:
    def get_android_msg(title,description,custom_content={},options={})
      options = _params_default(options,DEFAULT_ANDRIOD_FIELD)
      params = {}
      params.merge!("title"=>title)
      params.merge!("description"=>description)
      options.each do |key,value|
        params.merge!({key.to_s=>value})
      end
      params.merge!("custom_content"=>custom_content)
      params
    end


    #options:
    #method	string	是	方法名，必须存在：push_msg。
    #apikey	string	是	访问令牌，明文AK，可从此值获得App的信息，配合sign中的sk做合法性身份认证。
    #user_id	string	否	用户标识，在Android里，channel_id + userid指定某一个特定client。不超过256字节，如果存在此字段，则只推送给此用户。
    #push_type	uint	是	推送类型，取值范围为：1～3
    #1：单个人，必须指定user_id 和 channel_id （指定用户的指定设备）或者user_id（指定用户的所有设备）
    #
    #2：一群人，必须指定 tag
    #
    #3：所有人，无需指定tag、user_id、channel_id
    #
    #channel_id	uint	否	通道标识
    #tag	string	否	标签名称，不超过128字节
    #device_type	uint	否	设备类型，取值范围为：1～5
    #云推送支持多种设备，各种设备的类型编号如下：
    #
    #1：浏览器设备；
    #
    #2：PC设备；
    #
    #3：Andriod设备；
    #
    #4：iOS设备；
    #
    #5：Windows Phone设备；
    #
    #如果存在此字段，则向指定的设备类型推送消息。 默认为android设备类型。
    def push_msg_andriod(send_andriod_msg,options={})
      options = _params_default(options,DEFAULT_REQUREST_BAIDU_METHOD)
      options = _params_default(options,DEFAULT_PUSH_CONFIG)
      options[:msg_keys] = Time.now.to_i.to_s + ::SecureRandom.uuid.gsub!("-","")
      options.merge!(:messages => send_andriod_msg)
      request_server(options)
    end

    #---------推送相关函数------------END-------------------------------------------


    private


    #---------------基础函数-----------------------------
    #获取认证
    def get_sign(options,url_method)
      Base.get_sign(options,@options[:secret_key],url_method,@options[:url])
    end

    #获取请求参数
    def get_params(options,http_method)
      options.merge!(:apikey=>@options[:api_key])
      options.merge!(:sign=>get_sign(options,http_method))
      params = options
      params
    end

    #请求服务器
    def request_server(options)
      case options[:url_method]
        when HTTP_METHOD_POST
          Base.http_post(@options[:url],get_params(options,HTTP_METHOD_POST))
        when HTTP_METHOD_GET
          Base.http_get(@options[:url],get_params(options,HTTP_METHOD_GET))
      end
    end
    #----------------基础函数------------END-----------------------------


    #初始化options
    def _params_default(options,_default)
      _default.keys.each do |key|
        options[key] = options[key.to_s]||options[key]
        options[key] = options[key]||_default[key]
      end
      options
    end


    #类初始值
    DEFAULT_API = {
        :name => "测试应用",
        :secret_key => "7rWFgwXsECVcIzZ2jz5O9Zcy61CCkh6o",
        :api_key => "e9s6PNT5aTAwysl2D46c8HM4",
        :url => "http://channel.api.duapp.com/rest/2.0/channel/channel",
    }


    #所有请求百度的函数都需初始化的设置
    DEFAULT_REQUREST_BAIDU_METHOD = {
        :timestamp => Time.now.to_i,
        :expires => Time.now.to_i+60*10
    }

    #Bindlist查询函数的初始化设置
    DEFAULT_BINDLIST = {
        :start => 0,
        :limit => 20,
        :url_method => HTTP_METHOD_GET,
        :method => "query_bindlist",
    }

    #Andriod的推送的特有消息的初始化设置
    DEFAULT_ANDRIOD_FIELD = {
        :notification_builder_id => 0,
        :notification_basic_style => 7,
        :open_type => 0,
        :net_support=>1,
        :user_confirm=> 0,
        :url =>  "http://developer.baidu.com",
        :pkg_content=>"",
        :pkg_name=> "com.baidu.bccsclient",
        :pkg_version=>"0.1",
    }

    #推送类型函数的初始化设置
    DEFAULT_PUSH_CONFIG = {
        :method => "push_msg",
        :url_method => HTTP_METHOD_POST,
        :push_type => 3,
        :msg_keys => (Time.now.to_i.to_s+rand(999).to_s),
    }

    #设置标签函数的初始化设置
    DEFAULT_SET_TAG = {
       :method => "set_tag",
       :tag => "test",
       :url_method => HTTP_METHOD_POST,
    }

    DEFAULT_FETCH_TAG = {
        :method => "fetch_tag",
        :url_method => HTTP_METHOD_POST,
    }


    DEFAULT_DELETE_TAG = {
        :method => "delete_tag",
        :tag => "test",
    }


  end
end