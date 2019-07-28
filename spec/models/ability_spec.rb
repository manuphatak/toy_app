# frozen_string_literal: true

require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(current_user) }
  let(:current_user) { nil }

  context 'when not logged in' do
    describe 'User' do
      it { is_expected.not_to be_able_to(:create, User.new) }
      it { is_expected.not_to be_able_to(:read, User.new) }
      it { is_expected.not_to be_able_to(:update, User.new) }
      it { is_expected.not_to be_able_to(:destroy, User.new) }
    end

    describe 'Micropost' do
      it { is_expected.not_to be_able_to(:create, Micropost.new) }
      it { is_expected.not_to be_able_to(:read, Micropost.new) }
      it { is_expected.not_to be_able_to(:update, Micropost.new) }
      it { is_expected.not_to be_able_to(:destroy, Micropost.new) }
    end

    describe 'Relationship' do
      it { is_expected.not_to be_able_to(:create, Relationship.new) }
      it { is_expected.not_to be_able_to(:read, Relationship.new) }
      it { is_expected.not_to be_able_to(:update, Relationship.new) }
      it { is_expected.not_to be_able_to(:destroy, Relationship.new) }
    end
  end

  context 'when logged in as an admin' do
    let(:current_user) { create(:admin) }

    describe 'User' do
      it { is_expected.to be_able_to(:create, User.new) }
      it { is_expected.to be_able_to(:read, User.new) }
      it { is_expected.to be_able_to(:update, User.new) }
      it { is_expected.to be_able_to(:destroy, User.new) }

      it { is_expected.to be_able_to(:followers, User.new) }
      it { is_expected.to be_able_to(:following, User.new) }
    end

    describe 'Micropost' do
      it { is_expected.to be_able_to(:create, Micropost.new) }
      it { is_expected.to be_able_to(:read, Micropost.new) }
      it { is_expected.to be_able_to(:update, Micropost.new) }
      it { is_expected.to be_able_to(:destroy, Micropost.new) }
    end

    describe 'Relationship' do
      it { is_expected.to be_able_to(:create, Micropost.new) }
      it { is_expected.to be_able_to(:read, Micropost.new) }
      it { is_expected.to be_able_to(:update, Micropost.new) }
      it { is_expected.to be_able_to(:destroy, Micropost.new) }
    end
  end

  context 'when logged in as a user' do
    let(:current_user) { create(:user) }

    describe 'User' do
      it { is_expected.not_to be_able_to(:create, User.new) }
      it { is_expected.to be_able_to(:read, User.new) }
      it { is_expected.not_to be_able_to(:update, User.new) }
      it { is_expected.to be_able_to(:update, current_user) }
      it { is_expected.not_to be_able_to(:destroy, User.new) }
      it { is_expected.to be_able_to(:destroy, current_user) }

      it { is_expected.to be_able_to(:followers, User.new) }
      it { is_expected.to be_able_to(:following, User.new) }
    end

    describe 'Micropost' do
      it { is_expected.not_to be_able_to(:create, Micropost.new) }
      it { is_expected.to be_able_to(:create, current_user.microposts.build) }
      it { is_expected.to be_able_to(:read, Micropost.new) }
      it { is_expected.to be_able_to(:read, current_user.microposts.build) }
      it { is_expected.not_to be_able_to(:update, Micropost.new) }
      it { is_expected.to be_able_to(:update, current_user.microposts.build) }
      it { is_expected.not_to be_able_to(:destroy, Micropost.new) }
      it { is_expected.to be_able_to(:destroy, current_user.microposts.build) }
    end

    describe 'Relationship' do
      it { is_expected.not_to be_able_to(:create, Relationship.new) }
      it { is_expected.to be_able_to(:create, current_user.active_relationships.build) }
      it { is_expected.not_to be_able_to(:create, current_user.passive_relationships.build) }

      it { is_expected.to be_able_to(:read, Relationship.new) }
      it { is_expected.to be_able_to(:read, current_user.active_relationships.build) }
      it { is_expected.to be_able_to(:read, current_user.passive_relationships.build) }

      it { is_expected.not_to be_able_to(:update, Relationship.new) }
      it { is_expected.not_to be_able_to(:update, current_user.active_relationships.build) }
      it { is_expected.not_to be_able_to(:update, current_user.passive_relationships.build) }

      it { is_expected.not_to be_able_to(:destroy, Relationship.new) }
      it { is_expected.to be_able_to(:destroy, current_user.active_relationships.build) }
      it { is_expected.not_to be_able_to(:destroy, current_user.passive_relationships.build) }
    end
  end
end
