# frozen_string_literal: true

require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test 'should be root' do
    get root_url
    assert_response :success
    assert_select 'title', 'Toy App'
  end

  test 'should get home' do
    get home_url
    assert_response :success
    assert_select 'title', 'Toy App'
  end

  test 'should get help' do
    get help_url
    assert_response :success
    assert_select 'title', 'Help | Toy App'
  end

  test 'should get about' do
    get about_url
    assert_response :success
    assert_select 'title', 'About | Toy App'
  end

  test 'should get contact' do
    get contact_url
    assert_response :success
    assert_select 'title', 'Contact | Toy App'
  end
end
