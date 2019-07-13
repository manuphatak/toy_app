# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'microposts/index', type: :view do
  let!(:microposts) { FactoryBot.create_list(:micropost, 5) }
  before { assign(:microposts, Micropost.all.page(nil)) }

  it 'renders a list of microposts' do
    render

    aggregate_failures do
      microposts.each do |micropost|
        expect(rendered).to have_selector('ol>li', text: micropost.content)
      end
    end
  end
end
