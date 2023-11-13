# frozen_string_literal: true

class CreateBlockedUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :blocked_users, id: :uuid do |t|
      t.uuid :user_id
      t.uuid :other_user_id
      t.datetime :lift_date

      t.timestamps
    end

    add_foreign_key :blocked_users, :users, column: :user_id, primary_key: :id,type: :uuid
    add_foreign_key :blocked_users, :users, column: :other_user_id, primary_key: :id, type: :uuid
  end
end
