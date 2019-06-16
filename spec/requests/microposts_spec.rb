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
#  index_microposts_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe 'Microposts', type: :request do
  describe 'GET /microposts' do
    it 'works! (now write some real specs)' do
      get microposts_path
      expect(response).to have_http_status(200)
    end
  end
end
