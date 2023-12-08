# frozen_string_literal: true

module Modules
  module HttpErrorHandler
    include Modules::WithTransaction
    def with_http_error_handling(&block)
      Rails.error.record { with_transaction(&block) }
    rescue StandardError => e
      Rails.logger.error("HTTP Error: #{e.message}")
      error = if Rails.env.production?
                e.message
              else
                "#{e.class} | #{e.message} | #{e.backtrace&.first}"
              end
      respond_to do |format|
        format.html do
          flash[:danger] = error
        end
        format.json { render json: { error: }, status: :internal_server_error }
      end
    end
  end
end
