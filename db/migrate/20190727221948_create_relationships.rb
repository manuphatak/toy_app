# frozen_string_literal: true

class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :follower, foreign_key: true
      t.references :followed, foreign_key: true

      t.timestamps
    end

    add_index :relationships, %i[follower_id followed_id], unique: true
  end
end
