# frozen_string_literal: true

module ApplicationServices
  class JwtService
    HMAC_SECRET = ENV.fetch('JWT_SECRET') do
      raise ApplicationErrors::Jwt::JWTSecretKeyIsNotSetError if Rails.env.production?

      'topsecret'
    end

    def self.encode(payload = {}, expire = 24.hours.from_now.to_i)
      payload[:exp] = expire

      JWT.encode(payload, HMAC_SECRET, 'HS512')
    end

    def self.decode(token)
      JWT.decode(token, HMAC_SECRET, true, algorithm: 'HS512').first
    end
  end
end
