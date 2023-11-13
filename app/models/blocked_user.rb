# frozen_string_literal: true

class BlockedUser < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :other_user, class_name: 'User', foreign_key: 'other_user_id'
end
