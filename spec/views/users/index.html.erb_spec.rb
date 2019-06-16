# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  let!(:users) { assign(:users, FactoryBot.create_list(:user, 5))}


  it 'renders a list of users' do

    aggregate_failures do
      render
      assert_select 'tr>th', text: 'Name'.to_s, count: 1
      assert_select 'tr>th', text: 'Email'.to_s, count: 1
    end
  end
end
