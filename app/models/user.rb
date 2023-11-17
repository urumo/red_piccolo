# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_one :user_setting, dependent: :destroy
  has_many :blocked_users, dependent: :destroy
  has_many :chat_participants, dependent: :destroy
  has_many :chats, through: :chat_participants
  has_many :chat_messages, dependent: :destroy
  enum role: { user: 0, moderator: 1, admin: 2, superadmin: 3 }

  def full_name = "#{user_setting.first_name} #{user_setting.last_name}"

  after_create do
    UserSetting.create(user: self)
  end

  normalizes :email, with: ->(email) { email.strip.downcase }

  validates_presence_of :email
  validates_uniqueness_of :email, message: I18n.t('user.email_already_taken')
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP,
                              message: I18n.t('user.not_a_valid_email') }
  validates :password, format: { with: /\d/, message: I18n.t('user.password.number_missing') }, if: lambda {
    password.present?
  }
  validates :password, format: { with: /[A-Z]/, message: I18n.t('user.password.uppercase_missing') }, if: lambda {
    password.present?
  }
  validates :password, format: { with: /[a-z]/, message: I18n.t('user.password.lowercase_missing') }, if: lambda {
    password.present?
  }
  validates :password, format: { with: /\W/, message: I18n.t('user.password.special_character_missing') }, if: lambda {
    password.present?
  }
end
