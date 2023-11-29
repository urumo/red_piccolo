# frozen_string_literal: true

class BlockedUser < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :other_user, class_name: 'User'
end
