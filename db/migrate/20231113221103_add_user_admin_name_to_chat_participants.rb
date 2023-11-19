# frozen_string_literal: true

class AddUserAdminNameToChatParticipants < ActiveRecord::Migration[7.1]
  def change
    add_column :chat_participants, :user_admin_name, :string, default: 'member'
  end
end
