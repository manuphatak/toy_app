# frozen_string_literal: true

class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :follower, foreign_key: false, null: false
      t.references :followed, foreign_key: false, null: false

      t.timestamps
    end

    add_index :relationships, %i[follower_id followed_id], unique: true
    add_foreign_key :relationships, :users, column: :follower_id
    add_foreign_key :relationships, :users, column: :followed_id
  end
end
