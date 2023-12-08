# frozen_string_literal: true

module ApplicationServices
  class ErrorReportService
    TG_URL = 'https://api.telegram.org/bot'
    TG_METHOD = 'sendMessage'
    TG_KEY = ENV.fetch('VITE_TG_KEY') do
      raise 'VITE_TG_KEY is not set. Please set the VITE_TG_KEY environment variable for Telegram error reporting.' if Rails.env.production?
    end
    TG_CHAT_ID = ENV.fetch('VITE_TG_CHAT_ID') do
      raise 'VITE_TG_CHAT_ID is not set. Please set the VITE_TG_CHAT_ID environment variable for Telegram error reporting.' if Rails.env.production?
    end

    def self.send_to_telegram(message)
      uri = URI("#{TG_URL}#{TG_KEY}/#{TG_METHOD}")
      req = Net::HTTP::Post.new(uri)
      req.set_form_data(chat_id: TG_CHAT_ID, text: message)
      Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        response = http.request(req)
        unless response.is_a?(Net::HTTPSuccess)
          Rails.logger.error "Error sending message to Telegram: #{response.body}"
        end
      end
    end

    def self.report_error(error, context:, handled:, level:, src:)
      message = <<~HEREDOC
        Error: In #{src} #{error.class} | #{error.message}
        Context: #{context}
        Handled: #{handled}#{' '}
        Level: #{level}
        At: #{Time.zone.now}
        Source: #{error.backtrace&.first}
      HEREDOC

      begin
        ApplicationServices::ErrorReportService.send_to_telegram(message)
      rescue => e
        Rails.logger.error "Failed to send error report: #{e.message}"
      end
    end
  end
end
