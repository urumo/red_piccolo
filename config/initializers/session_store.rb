# frozen_string_literal: true

SESSION_KEY = '_red_piccolo_session'
begin
  REDIS_SERVER = Rails.application.config_for('redis/shared', env: :session)[:url]
  raise 'Redis Session Store not configured' if REDIS_SERVER.nil?

  Rails.application.config.session_store :redis_session_store,
                                         key: SESSION_KEY,
                                         on_redis_down: ->(e, env, sid) { raise e, "#{env} #{sid}" },
                                         on_session_load_error: ->(e, sid) { raise e, sid },
                                         serializer: :json,
                                         cookie_only: false,
                                         secure: Rails.env.production?,
                                         redis: {
                                           expire_after: 1.day,
                                           key_prefix: 'red_piccolo:session:',
                                           url: REDIS_SERVER
                                         }
  Rails.logger.info 'Redis Session Store configured...'
rescue StandardError
  Rails.application.config.session_store :cookie_store,
                                         key: SESSION_KEY,
                                         expire_after: 1.day,
                                         secure: Rails.env.production?,
                                         httponly: true,
                                         same_site: :strict
  Rails.logger.info 'Cookie Session Store configured'
end
