require 'rails_helper'

RSpec.describe "relationships/edit", type: :view do
  before(:each) do
    @relationship = assign(:relationship, Relationship.create!(
      :follower_id => nil,
      :followed_id => nil
    ))
  end

  it "renders the edit relationship form" do
    render

    assert_select "form[action=?][method=?]", relationship_path(@relationship), "post" do

      assert_select "input[name=?]", "relationship[follower_id_id]"

      assert_select "input[name=?]", "relationship[followed_id_id]"
    end
  end
end
