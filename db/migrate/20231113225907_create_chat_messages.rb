# frozen_string_literal: true

class CreateChatMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :chat_messages, id: :uuid do |t|
      t.belongs_to :chat, null: false, foreign_key: true, type: :uuid
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid
      t.text :content

      t.timestamps
    end
  end
end
