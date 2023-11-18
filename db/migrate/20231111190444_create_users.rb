# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email, null: false
      t.string :password_digest
      t.string :email_change_token
      t.string :password_reset_token
      t.string :password_salt

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
