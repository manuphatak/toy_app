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
  subject(:micropost) { create(:micropost) }

  describe 'validations' do
    it { is_expected.to be_valid }

    context 'with no user' do
      before { micropost.user_id = nil }
      it { is_expected.not_to be_valid }
    end

    context 'with empty content' do
      before { micropost.content = '    ' }
      it { is_expected.not_to be_valid }
    end

    context 'with content longer than 140 characters' do
      before { micropost.content = 'a' * 141 }
      it { is_expected.not_to be_valid }
    end
  end
end
