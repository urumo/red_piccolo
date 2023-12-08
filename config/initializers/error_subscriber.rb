# frozen_string_literal: true

class ErrorSubscriber
  def report(error, handled:, severity:, context:, source: nil)
    ApplicationServices::ErrorReportService
      .report_error(error, context:, handled:, level: severity, src: source)
  end
end

Rails.error.subscribe(ErrorSubscriber.new)
