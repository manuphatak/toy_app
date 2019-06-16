# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UsersHelper, type: :helper do
  describe '#gravatar_for' do
    let(:user) { FactoryBot.build_stubbed(:user) }
    let(:image) { helper.gravatar_for(user) }

    it 'creates a gravatar image tag' do
      aggregate_failures do
        expect(image).to match(/alt="#{user.name}"/)
        expect(image).to match(%r{src="https://secure.gravatar.com/avatar/[0-9a-f]+\?.*"})
      end
    end
  end
end
