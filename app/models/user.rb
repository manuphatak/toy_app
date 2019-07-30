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

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable, :trackable, :lockable, :confirmable,
         :recoverable

  has_many :microposts, dependent: :destroy
  has_many :active_relationships,
           class_name: 'Relationship',
           foreign_key: :follower_id,
           dependent: :destroy,
           inverse_of: :follower
  has_many :passive_relationships,
           class_name: 'Relationship',
           foreign_key: :followed_id,
           dependent: :destroy,
           inverse_of: :followed
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, presence: true, length: { maximum: 64 }
  validates :email, length: { maximum: 256 }

  self.per_page = 20

  def following?(other_user)
    following.include?(other_user)
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def feed
    Micropost
      .where(user_id: Relationship.select(:followed_id).where(follower_id: id))
      .or(Micropost.where(user_id: id))
      .order(created_at: :desc)
  end
end
