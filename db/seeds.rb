# frozen_string_literal: true

# start_time = Time.now

# def add_users(chat)
#   DomainServices::Chat::AddUserToChatService.call(chat, chat.owner, User.all.sample)
# rescue StandardError => _e
#   nil
# end
#
# def add_messages(chat, content)
#   DomainServices::Chat::SendMessageService.call(chat.users.sample, chat, content)
# rescue StandardError => _e
#   nil
# end
#
# emails = Array.new(500).map { Faker::Internet.email }
# emails_done_time = Time.now
# puts "Emails: #{emails_done_time - start_time}"
# chat_info = Array.new(450).map { { title: Faker::Lorem.word, description: Faker::Lorem.sentence } }
# chat_info_done_time = Time.now
# puts "Chat info: #{chat_info_done_time - emails_done_time}"
# messages = Array.new(2000 * 450).map { Faker::Lorem.sentence }
# messages_done_time = Time.now
# puts "Messages: #{messages_done_time - chat_info_done_time}"
#
# if Rails.env.development? || Rails.env.test?
#   emails.each do |email|
#     User.create!(email:, password: 'P@ssw0rd', role: :user)
#   end
#
#   chat_info.each_with_index do |info, chat_index|
#     chat = DomainServices::Chat::CreateChatService.call(User.all.sample, info[:title], info[:description])
#
#     450.times do
#       add_users(chat)
#     end
#
#     2000.times do |i|
#       add_messages(chat, messages[(chat_index * i) + i])
#     end
#   end
# end
#
# done_time = Time.now
# puts "Done: #{done_time - start_time}"

email = ENV.fetch('SUPERADMIN_EMAIL', 'admin@svck.dev')
password = ENV.fetch('SUPERADMIN_PASSWORD', 'P@ssw0rd')
User.create!(email:, password:, role: :superadmin)
