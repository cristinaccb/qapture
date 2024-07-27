require "test_helper"

class QrCodesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get qr_codes_create_url
    assert_response :success
  end

  test "should get destroy" do
    get qr_codes_destroy_url
    assert_response :success
  end
end
