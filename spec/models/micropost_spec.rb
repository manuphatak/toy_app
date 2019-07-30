# frozen_string_literal: true

# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_microposts_on_user_id                 (user_id)
#  index_microposts_on_user_id_and_created_at  (user_id,created_at)
#

require 'rails_helper'

RSpec.describe Micropost, type: :model do
  describe 'validations' do
    subject(:micropost) { create(:micropost) }
    it { is_expected.to be_valid }
    it { is_expected.to accept_content_types('image/png', 'image/jpeg', 'image/jpg', 'image/gif').for(:image) }
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_length_of(:content).is_at_most(140) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to belong_to(:user) }
  end
end
