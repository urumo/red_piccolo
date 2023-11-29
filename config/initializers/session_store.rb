# frozen_string_literal: true

#
# session_url = "#{ENV.fetch('REDIS_URL', 'redis://127.0.0.1:6379')}/0/session"
# secure = Rails.env.production?
# key = Rails.env.production? ? "_red_piccolo_session" : "_red_piccolo_session_#{Rails.env}"
# domain = ENV.fetch("DOMAIN_NAME", "localhost")
#
# Rails.application.config.session_store :redis_store,
#                                        url: session_url,
#                                        expire_after: 180.days,
#                                        key: key,
#                                        domain: ,
#                                        threadsafe: true,
#                                        secure: ,
#                                        same_site: :lax,
#                                        httponly: true
#

# # }

SESSION_KEY = '_red_piccolo_session'
if File.exist?(file_path)
  REDIS_SERVER = Rails.application.config_for('redis/shared')[:url]
  raise 'Redis Session Store not configured' if REDIS_SERVER.nil?

  Rails.application.config.session_store :redis_session_store,
                                         key: SESSION_KEY,
                                         on_redis_down: ->(e, env, sid) { raise e, "#{env} #{sid}" },
                                         on_session_load_error: ->(e, sid) { raise e, sid },
                                         serializer: :json,
                                         redis: {
                                           expire_after: 1.day,
                                           key_prefix: 'red_piccolo:session:',
                                           url: REDIS_SERVER
                                         }
  Rails.logger.info 'Redis Session Store configured...'
else
  Rails.application.config.session_store :cookie_store,
                                         key: SESSION_KEY,
                                         expire_after: 1.day,
                                         secure: Rails.env.production?,
                                         httponly: false,
                                         same_site: :strict
  Rails.logger.info 'Cookie Session Store configured'
end
