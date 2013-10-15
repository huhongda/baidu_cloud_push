#encoding:utf-8

module Baidupush
  class BaseError < RuntimeError
    # To change this template use File | Settings | File Templates.
    #错误的类型
    attr_reader :type
    #错误的状态码
    attr_reader :status
    #错误的信息
    attr_reader :msg


    #缺少某些参数
    def self.missing_parameters
      1
    end

    #子类应该重写此方法
    #为每个子类分配不同的错误起始状态值
    def error_num_start
      100
    end

    # 初始化
    # Arguments:
    #   error_type: (Integer)
    #   error_msg:  (String)
    def initialize(error_type,error_msg="")
      @type = error_type
      @msg = error_msg
      set_status
    end

    # 获取状态值
    def status
      @status
    end

    def default_error_msg
      case @type
        when 0
          "未知错误"
        when 1
          "缺少某些参数"
        else
          "未知错误"
      end
    end

    #用于子类中定义独属于子类的错误
    # Example:
    #   >> BaseError.new.get_error_msg
    #   => {:simale=>"缺少某些参数",:detailed=>"缺少参数name"}
    def get_error_msg
      ret = default_error_msg
      if ret.eql?("未知错误")
        case @type
          when 0
            ret = "未知错误"
          when 1
            ret = "缺少某些参数"
          else
            ret = "未知错误"
        end
      end
      ret = {:simaple => ret, :detailed => @msg}
    end

    def set_status
      @status = error_num_start + @type
    end

  end
end