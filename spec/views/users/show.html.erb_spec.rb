# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  let!(:user) { assign(:user, build_stubbed(:user, name: 'Test User', microposts: build_list(:micropost, 5))) }

  it 'renders attributes in <p>' do
    render

    aggregate_failures do
      expect(rendered).to have_selector format('h1>img[alt=%p]', 'Test User')
      expect(rendered).to have_selector 'p', text: user.email
      user.microposts.each do |micropost|
        expect(rendered).to have_selector 'ul>li', text: micropost.content
      end
    end
  end
end
