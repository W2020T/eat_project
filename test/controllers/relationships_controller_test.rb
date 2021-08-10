# frozen_string_literal: true

require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test 'should get followers' do
    get relationships_followers_url
    assert_response :success
  end
end
