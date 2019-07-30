# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'microposts/index', type: :view do
  let(:user) { create(:user, :with_posts) }
  let!(:microposts) { assign(:microposts, user.microposts.page(nil)) }

  it 'renders a list of microposts' do
    render

    aggregate_failures do
      microposts.each do |micropost|
        expect(rendered).to have_selector('ol>li', text: micropost.content)
      end
    end
  end
end
