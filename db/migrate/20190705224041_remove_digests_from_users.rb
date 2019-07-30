# frozen_string_literal: true

class RemoveDigestsFromUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.remove_column :remember_digest, :string
      t.remove_column :password_digest, :string
    end
  end
end
