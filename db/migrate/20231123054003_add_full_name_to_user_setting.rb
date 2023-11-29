# frozen_string_literal: true

class AddFullNameToUserSetting < ActiveRecord::Migration[7.1]
  def change
    add_column :user_settings, :full_name, :string, default: ''
  end
end
