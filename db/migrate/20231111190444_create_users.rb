# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :password
      t.string :password_digest

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
