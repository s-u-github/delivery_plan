require 'test_helper'

class DeliveryinfosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get deliveryinfos_new_url
    assert_response :success
  end

end
