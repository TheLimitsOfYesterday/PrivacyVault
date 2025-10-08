require "test_helper"

class EncryptionControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get encryption_index_url
    assert_response :success
  end
end
