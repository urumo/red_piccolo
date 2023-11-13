# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_one :user_setting, dependent: :destroy

  after_create do
    UserSetting.create(user: self)
  end

  normalizes :email, with: ->(email) { email.strip.downcase }

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP,
                              message: 'must be a valid email address' }
  validates :password, format: { with: /\d/, message: 'must contain at least one number' }, if: -> { password.present? }
  validates :password, format: { with: /[A-Z]/, message: 'must contain at least one uppercase letter' }, if: lambda {
                                                                                                               password.present?
                                                                                                             }
  validates :password, format: { with: /[a-z]/, message: 'must contain at least one lowercase letter' }, if: lambda {
                                                                                                               password.present?
                                                                                                             }
  validates :password, format: { with: /\W/, message: 'must contain at least one special character' }, if: lambda {
                                                                                                             password.present?
                                                                                                           }
end
