# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  name            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  has_many :microposts, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :email,
            presence: true,
            length: { maximum: 50 },
            format: { with: URI::MailTo::EMAIL_REGEXP },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }, on: :create

  before_save { email.downcase! }

  def self.digest(password)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(password, cost: cost)
  end
end
