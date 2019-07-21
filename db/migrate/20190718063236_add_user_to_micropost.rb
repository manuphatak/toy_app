# frozen_string_literal: true

class AddUserToMicropost < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :microposts, :users, on_delete: :cascade
  end
end
