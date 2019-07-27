require 'rails_helper'

RSpec.describe "relationships/show", type: :view do
  before(:each) do
    @relationship = assign(:relationship, Relationship.create!(
      :follower_id => nil,
      :followed_id => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
