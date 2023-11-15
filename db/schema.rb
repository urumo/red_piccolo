# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_231_113_225_957) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pgcrypto'
  enable_extension 'plpgsql'

  create_table 'blocked_users', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'user_id'
    t.uuid 'other_user_id'
    t.datetime 'lift_date'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'chat_messages', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'chat_id', null: false
    t.uuid 'user_id', null: false
    t.text 'content'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['chat_id'], name: 'index_chat_messages_on_chat_id'
    t.index ['user_id'], name: 'index_chat_messages_on_user_id'
  end

  create_table 'chat_participants', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'chat_id', null: false
    t.uuid 'user_id', null: false
    t.integer 'user_role'
    t.boolean 'is_kicked'
    t.boolean 'is_blocked'
    t.boolean 'is_restricted'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'user_admin_name', default: 'member'
    t.index ['chat_id'], name: 'index_chat_participants_on_chat_id'
    t.index ['user_id'], name: 'index_chat_participants_on_user_id'
  end

  create_table 'chats', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'title'
    t.string 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'message_histories', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'chat_message_id', null: false
    t.text 'content'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['chat_message_id'], name: 'index_message_histories_on_chat_message_id'
  end

  create_table 'user_settings', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.date 'date_of_birth'
    t.uuid 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_user_settings_on_user_id'
  end

  create_table 'users', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'email'
    t.string 'password'
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'role', default: 0
    t.index ['email'], name: 'index_users_on_email', unique: true
  end

  add_foreign_key 'blocked_users', 'users'
  add_foreign_key 'blocked_users', 'users', column: 'other_user_id'
  add_foreign_key 'chat_messages', 'chats'
  add_foreign_key 'chat_messages', 'users'
  add_foreign_key 'chat_participants', 'chats'
  add_foreign_key 'chat_participants', 'users'
  add_foreign_key 'message_histories', 'chat_messages'
  add_foreign_key 'user_settings', 'users'
end
