# frozen_string_literal: true

class RemoveDigestsFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :remember_digest, :string
    remove_column :users, :password_digest, :string
  end
end
