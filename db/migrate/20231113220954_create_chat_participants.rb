# frozen_string_literal: true

class CreateChatParticipants < ActiveRecord::Migration[7.1]
  def change
    create_table :chat_participants, id: :uuid do |t|
      t.belongs_to :chat, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.integer :user_role
      t.boolean :is_kicked
      t.boolean :is_blocked
      t.boolean :is_restricted

      t.timestamps
    end

    add_index :chat_participants, %i[chat_id user_id], unique: true
  end
end
