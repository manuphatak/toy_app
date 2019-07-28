# frozen_string_literal: true

# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :integer          not null
#  follower_id :integer          not null
#
# Indexes
#
#  index_relationships_on_followed_id                  (followed_id)
#  index_relationships_on_follower_id                  (follower_id)
#  index_relationships_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#

require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'validations' do
    subject(:relationship) { create(:relationship) }
    it { is_expected.to be_valid }

    it { is_expected.to belong_to(:followed).class_name('User') }
    it { is_expected.to belong_to(:follower).class_name('User') }

    it { is_expected.to validate_presence_of(:followed_id) }
    it { is_expected.to validate_presence_of(:follower_id) }
  end
end
