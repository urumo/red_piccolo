# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_one :user_setting, dependent: :destroy
  has_many :blocked_users, dependent: :destroy
  has_many :chat_participants, dependent: :destroy
  has_many :chats, through: :chat_participants
  has_many :chat_messages, dependent: :destroy
  enum role: { user: 0, moderator: 1, admin: 2, superadmin: 3 }

  after_create do
    UserSetting.create!(user: self)
  end

  def first_name = user_setting.first_name
  def last_name = user_setting.last_name
  def date_of_birth = user_setting.date_of_birth
  def full_name = "#{first_name} #{last_name}"

  normalizes :email, with: ->(email) { email.strip.downcase }

  validates_presence_of :email
  validates_uniqueness_of :email, message: I18n.t('user.email_already_taken')
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP,
                              message: I18n.t('user.not_a_valid_email') }
  validates :password, length: { minimum: 8, message: I18n.t('user.password.too_short', count: 8) },
                       if: :password_present?
  validates :password, format: { with: /\W/, message: I18n.t('user.password.special_character_missing') },
                       if: :password_present?
  validates :password, format: { with: /[a-z]/, message: I18n.t('user.password.lowercase_missing') },
                       if: :password_present?
  validates :password, format: { with: /[A-Z]/, message: I18n.t('user.password.uppercase_missing') },
                       if: :password_present?
  validates :password, format: { with: /\d/, message: I18n.t('user.password.number_missing') }, if: :password_present?

  private

  def password_present?
    @password_present ||= password.present?
  end
end
