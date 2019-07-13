# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  let!(:user) { assign(:user, create(:user, :with_posts, posts_count: 5)) }
  let!(:microposts) { assign(:microposts, user.microposts.page(nil)) }

  it 'renders attributes in <p>' do
    render

    aggregate_failures do
      expect(rendered).to have_selector format('h1>img[alt=%p]', user.name)
      user.microposts.each do |micropost|
        expect(rendered).to have_selector 'ol>li', text: micropost.content
      end
    end
  end
end
