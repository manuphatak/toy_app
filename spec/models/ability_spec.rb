# frozen_string_literal: true

require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(current_user) }
  let(:current_user) { nil }

  context 'when not logged in' do
    describe 'User' do
      it { is_expected.not_to be_able_to(:create, User) }
      it { is_expected.not_to be_able_to(:read, User) }
      it { is_expected.not_to be_able_to(:update, User) }
      it { is_expected.not_to be_able_to(:destroy, User) }
    end
  end

  context 'when logged in as an admin' do
    let(:current_user) { create(:admin) }

    describe 'User' do
      it { is_expected.to be_able_to(:create, User) }
      it { is_expected.to be_able_to(:read, User) }
      it { is_expected.to be_able_to(:update, User) }
      it { is_expected.to be_able_to(:destroy, User) }
    end

    describe 'Micropost' do
      it { is_expected.to be_able_to(:create, Micropost) }
      it { is_expected.to be_able_to(:read, Micropost) }
      it { is_expected.to be_able_to(:update, Micropost) }
      it { is_expected.to be_able_to(:destroy, Micropost) }
    end
  end

  context 'when logged in as a user' do
    let(:current_user) { create(:user) }
    describe 'User' do
      it { is_expected.not_to be_able_to(:create, User) }
      it { is_expected.to be_able_to(:read, User) }
      it { is_expected.not_to be_able_to(:update, User.new) }
      it { is_expected.to be_able_to(:update, current_user) }
      it { is_expected.not_to be_able_to(:destroy, User.new) }
      it { is_expected.to be_able_to(:destroy, current_user) }
    end
  end
end
