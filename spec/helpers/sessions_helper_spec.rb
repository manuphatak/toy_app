# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do
  let(:user) { create(:user) }
  describe '#login' do
    it 'adds user.id to the session' do
      expect { helper.login(user) }.to change { helper.session[:user_id] }.from(nil).to(user.id)
    end
  end

  describe '#logout' do
    before { helper.login(user) }

    it 'removes user.id from the session' do
      expect { helper.logout }.to change { helper.logged_in? }.from(true).to(false)
    end
    it 'resets current_usern' do
      expect { helper.logout }.to change { helper.current_user }.from(user).to(nil)
    end
  end

  describe '#remember' do
    it 'allows a users authentication to be stored in a cookie' do
      expect { helper.remember(user) }.to \
        change { user.authenticated?(helper.cookies[:remember_token]) }.from(false).to(true)
    end

    it 'allows a users authentication to be stored in a cookie' do
      expect { helper.remember(user) }.to change { helper.current_user }.from(nil).to(user)
    end
  end

  describe '#forget' do
    before { helper.remember(user) }
    it 'allows a users authentication to be stored in a cookie' do
      expect { helper.forget(helper.current_user) }.to change { helper.cookies.signed[:user_id] }.from(user.id).to(nil)
    end
  end
end
