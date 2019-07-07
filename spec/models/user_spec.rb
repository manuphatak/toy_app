# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  admin                  :boolean          default(FALSE), not null
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:stubbed_user) { FactoryBot.build_stubbed(:user) }
  let(:user) { FactoryBot.create(:user) }

  describe 'validations' do
    it 'should be valid' do
      expect(stubbed_user).to be_valid
    end

    it 'name should be present' do
      stubbed_user.name = '      '
      expect(stubbed_user).not_to be_valid
    end

    it 'name should not be too long' do
      stubbed_user.name = 'a' * 65
      expect(stubbed_user).not_to be_valid
    end

    it 'email should be present' do
      stubbed_user.email = '      '
      expect(stubbed_user).not_to be_valid
    end

    it 'email should not be too long' do
      stubbed_user.email = 'a' * 256 + '@example.com'
      expect(stubbed_user).not_to be_valid
    end

    it 'email should be a valid email address' do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      aggregate_failures do
        valid_addresses.each do |valid_address|
          stubbed_user.email = valid_address
          expect(stubbed_user).to be_valid, "#{valid_address.inspect} should be valid"
        end
      end
    end

    it 'email should be unique' do
      other_user = FactoryBot.build_stubbed(:user, email: user.email.upcase)
      expect(other_user).not_to be_valid
    end

    it 'emails are stored as lowercase' do
      expect do
        user.update(email: 'TEST@TOY.APP')
      end.to change { user.email }.from(user.email).to('test@toy.app')
    end
  end
end
