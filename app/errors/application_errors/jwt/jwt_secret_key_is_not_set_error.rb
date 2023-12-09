# frozen_string_literal: true

module ApplicationErrors
  module Jwt
    class JwtSecretKeyIsNotSetError < StandardError
      def message = I18n.t('errors.jwt_secret_key_is_not_set')
    end
  end
end
