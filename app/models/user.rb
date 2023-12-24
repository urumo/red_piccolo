# frozen_string_literal: true

class User < ApplicationRecord
  default_scope { with_user_setting }
  scope :with_user_setting, -> { includes(:user_setting) }
  scope :with_blocked_users, -> { includes(:blocked_users) }
  scope :with_chats, -> { includes(chats: :chat_messages) }
  scope :with_chat_messages, -> { includes(:chat_messages) }
  scope :with_all, lambda {
    with_user_setting
      .with_blocked_users
      .with_chats
  }
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

  delegate :first_name, to: :user_setting

  delegate :last_name, to: :user_setting

  delegate :date_of_birth, to: :user_setting

  def full_name
    name = user_setting.full_name
    @full_name ||= name.strip.empty? ? email : name
  end

  normalizes :email, with: ->(email) { email.strip.downcase }

  validates :email, presence: true
  validates :email, uniqueness: { message: I18n.t('user.email_already_taken') }
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

  def as_dto
    dto = super
    dto['full_name'] = full_name
    dto
  end

  private

  def password_present?
    @password_present ||= password.present?
  end
end
