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

class Micropost < ApplicationRecord
  CONTENT_TYPES = ['image/png', 'image/jpeg', 'image/jpg', 'image/gif'].freeze

  belongs_to :user
  has_one_attached :image

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :image, content_type: CONTENT_TYPES, byte_size: { maximum: 5.megabytes }

  default_scope -> { order(created_at: :desc) }
end
