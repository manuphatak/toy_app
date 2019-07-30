# frozen_string_literal: true

class MakeUsersEmailNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:users, :email, true, default: '')
  end
end
