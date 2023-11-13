# frozen_string_literal: true

class CreateMessageHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :message_histories, id: :uuid do |t|
      t.references :chat_message, null: false, foreign_key: true, type: :uuid
      t.text :content

      t.timestamps
    end
  end
end
