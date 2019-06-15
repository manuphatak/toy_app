# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  fixtures :users

  before(:each) do
    @user = assign(:user, users(:user))
  end

  it 'renders attributes in <p>' do
    render
    aggregate_failures do
      expect(rendered).to match(/alt="#{@user.name}"/)
      expect(rendered).to match(/Email/)
      expect(rendered).to match(/Posts/)
    end
  end
end
