# frozen_string_literal: true

# == Schema Information
#
# Table name: relationships
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :bigint           not null
#  follower_id :bigint           not null
#
# Indexes
#
#  index_relationships_on_followed_id                  (followed_id)
#  index_relationships_on_follower_id                  (follower_id)
#  index_relationships_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (followed_id => users.id)
#  fk_rails_...  (follower_id => users.id)
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

    context 'when user follows self' do
      before { relationship.follower_id = relationship.followed_id }

      it 'is invalid with a useful error message' do
        aggregate_failures do
          expect(relationship).not_to be_valid
          expect(relationship.errors.full_messages).to include('User cannot follow self')
        end
      end
    end
  end
end
