# frozen_string_literal: true

require 'test_helper'
require 'action_view'

class UsersHelperTest < ActiveSupport::TestCase
  include ActionView::Helpers::AssetTagHelper
  include UsersHelper
  def setup
    @user = users(:user)
  end

  test '#gravatar_for creates a valid gravatar image' do
    gravatar = gravatar_for(@user)
    assert_match(/alt="#{@user.name}"/, gravatar)
    assert_match %r{src="https://secure.gravatar.com/avatar/[0-9a-f]+\?.*"}, gravatar
  end
end
