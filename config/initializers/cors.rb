# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    if Rails.env.development?
      origins 'http://localhost:3000', 'http://127.0.0.1:3000', 'https://localhost:3000', 'https://127.0.0.1:3000'
    else
      origins 'https://svck.dev', 'https://chat.svck.dev', 'https://www.svck.dev', 'https://*.svck.dev'
    end
    resource '*', headers: :any, methods: :any, credentials: true
  end
end
