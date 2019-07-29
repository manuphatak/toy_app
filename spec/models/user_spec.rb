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
  subject(:user) { create(:user) }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to have_many(:microposts).dependent(:destroy) }
    it {
      is_expected.to have_many(:active_relationships)
        .class_name('Relationship')
        .with_foreign_key(:follower_id)
        .dependent(:destroy)
    }
    it {
      is_expected.to have_many(:passive_relationships)
        .class_name('Relationship')
        .with_foreign_key(:followed_id)
        .dependent(:destroy)
    }
    it { is_expected.to have_many(:following).through(:active_relationships).source(:followed) }
    it { is_expected.to have_many(:followers).through(:passive_relationships).source(:follower) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(64) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

    describe '#email' do
      it 'has a max length' do
        user.email = 'a' * 256 + '@example.com'
        expect(user).not_to be_valid
      end

      it 'has a legit address' do
        valid_addresses = %w[user22@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
        aggregate_failures do
          valid_addresses.each do |valid_address|
            user.email = valid_address
            expect(user).to be_valid, "#{valid_address.inspect} is valid"
          end
        end
      end
      it 'stores emails as lowercase' do
        expect { user.update(email: 'TEST@TOY.APP') }.to change(user, :unconfirmed_email).from(nil).to('test@toy.app')
      end
    end
  end

  describe '#destroy' do
    context 'given a user with microposts' do
      let!(:user) { create(:user, :with_posts, posts_count: 10) }

      it 'deleting also destroys associated microposts' do
        expect { user.destroy }.to change(user.microposts, :count).from(10).to(0)
      end
    end
  end

  describe '#follow' do
    context 'given multiple users' do
      subject(:joe) { create(:user, name: 'Joe') }
      subject(:jane) { create(:user, name: 'Jane') }

      specify { expect(joe).not_to be_following(jane) }
      specify { expect(jane).not_to be_following(joe) }

      context 'after joe follows jane' do
        before { joe.follow(jane) }

        specify { expect(joe).to be_following(jane) }
        specify { expect(jane).not_to be_following(joe) }

        context 'after joe stops following jane' do
          before { joe.unfollow(jane) }
          specify { expect(joe).not_to be_following(jane) }
          specify { expect(jane).not_to be_following(joe) }
        end
      end
    end
  end
end
