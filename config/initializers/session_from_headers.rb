# frozen_string_literal: true

class SessionFromHeaders
  def initialize(app)
    @app = app
  end

  def call(env)
    # debugger
    session_token = env['HTTP_X_AUTH_ID']
    env['rack.session'] = { token: session_token } if session_token

    @app.call(env)
  end
end
# ActionDispatch::Request::Session.find
# Rails.application.config.middleware.use SessionFromHeaders
