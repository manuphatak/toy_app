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
  subject(:user) { FactoryBot.create(:user) }

  describe 'validations' do
    it 'is valid' do
      expect(user).to be_valid
    end

    it 'has a name' do
      user.name = '      '
      expect(user).not_to be_valid
    end

    it 'has a name with a max length' do
      user.name = 'a' * 65
      expect(user).not_to be_valid
    end

    it 'has an email' do
      user.email = '      '
      expect(user).not_to be_valid
    end

    it 'has an email with a max length' do
      user.email = 'a' * 256 + '@example.com'
      expect(user).not_to be_valid
    end

    it 'has an email with a legit email address' do
      valid_addresses = %w[user22@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      aggregate_failures do
        valid_addresses.each do |valid_address|
          user.email = valid_address
          expect(user).to be_valid, "#{valid_address.inspect} is valid"
        end
      end
    end

    it 'has a unique email' do
      other_user = FactoryBot.build(:user, email: user.email.upcase)
      expect(other_user).not_to be_valid
    end
  end

  it 'stores emails as lowercase' do
    expect do
      user.update(email: 'TEST@TOY.APP')
    end.to change(user, :unconfirmed_email).from(nil).to('test@toy.app')
  end

  context 'given a user with microposts' do
    let!(:user) { create(:user, :with_posts, posts_count: 10) }

    it 'deleting also destroys associated microposts' do
      expect { user.destroy }.to change(user.microposts, :count).from(10).to(0)
    end
  end
end
