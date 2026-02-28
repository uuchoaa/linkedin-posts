# frozen_string_literal: true

class CreateAuthorsAndAddAuthorToPosts < ActiveRecord::Migration[8.1]
  def change
    create_table :authors do |t|
      t.string :name, null: false
      t.timestamps
    end

    add_reference :posts, :author, foreign_key: true
  end
end
