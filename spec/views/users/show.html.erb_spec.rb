# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  let!(:user) { assign(:user, create(:user, :with_posts, posts_count: 5, name: 'Joe Sixpack')) }
  let!(:microposts) { assign(:microposts, user.microposts.page(1)) }

  it 'renders attributes in <p>' do
    render

    aggregate_failures do
      within 'aside' do
        expect(rendered).to have_selector format('img[alt=%p]', user.name)
      end

      within '.microposts' do
        user.microposts.each do |micropost|
          expect(rendered).to have_selector "#micropost-#{micropost.id}", text: micropost.content
        end
      end
    end
  end
end
