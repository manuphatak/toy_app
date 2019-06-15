# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :users
  let(:user) { users(:user) }

  it 'should be valid' do
    expect(user).to be_valid
  end

  it 'name should be present' do
    user.name = '      '
    expect(user).not_to be_valid
  end

  it 'name should not be too long' do
    user.name = 'a' * 51
    expect(user).not_to be_valid
  end

  it 'email should be present' do
    user.email = '      '
    expect(user).not_to be_valid
  end

  it 'email should not be too long' do
    user.email = 'a' * 244 + '@example.com'
    expect(user).not_to be_valid
  end

  it 'email should be a valid email address' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    aggregate_failures do
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid, "#{valid_address.inspect} should be valid"
      end
    end
  end

  it 'email should be unique' do
    other_user = user.dup
    other_user.email = user.email.upcase
    user.save
    expect(other_user).not_to be_valid
  end

  it 'emails are stored as lowercase' do
    expect do
      user.update(email: 'TEST@TOY.APP')
    end.to change { user.email }.from(user.email).to('test@toy.app')
  end
end
