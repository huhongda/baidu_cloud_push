#encoding:utf-8

require 'test/unit'
require "#{File.dirname(__FILE__)}/../lib/Baidupush/base"
require "#{File.dirname(__FILE__)}/../lib/Baidupush/api"

class TestBase < Test::Unit::TestCase
  # To change this template use File | Settings | File Templates.
  include Baidupush

  def test_api_query_bindlist
    assert_block do
      p "Request query bindlist"
      api = Api.new
      ret = api.query_bindlist
      p ret
      ret
    end
  end

  def test_send_msg_andriod
    assert_block do
      p  "Request Send msg andriod"
      api = Api.new
      ret = api.push_msg_andriod(api.get_android_msg("测试","这是个测试",{"c1"=>1,"c2"=>2}))
      p ret
      ret
    end
  end

  def test_set_tag
    assert_block do
      p "Requrest Set tag"
      api = Api.new
      ret = api.tag_set
      p ret
      ret
    end
  end

  def test_fetch_tag
    assert_block do
      p "Request Fetch tag"
      api = Api.new
      ret = api.tag_fetch
      p ret
      ret
    end
  end

 def test_delete_tag
   assert_block do
     p "Request Delete tag"
     api = Api.new
     ret = api.tag_delete
     p ret
     ret
   end
 end

end