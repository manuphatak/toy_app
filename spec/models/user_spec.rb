# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:stubbed_user) { FactoryBot.build_stubbed(:user) }
  let(:user) { FactoryBot.create(:user) }

  it 'should be valid' do
    expect(stubbed_user).to be_valid
  end

  it 'name should be present' do
    stubbed_user.name = '      '
    expect(stubbed_user).not_to be_valid
  end

  it 'name should not be too long' do
    stubbed_user.name = 'a' * 51
    expect(stubbed_user).not_to be_valid
  end

  it 'email should be present' do
    stubbed_user.email = '      '
    expect(stubbed_user).not_to be_valid
  end

  it 'email should not be too long' do
    stubbed_user.email = 'a' * 244 + '@example.com'
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