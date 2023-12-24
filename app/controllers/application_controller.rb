# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Modules::HttpErrorHandler
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info
  around_action :wrap_in_error_handler
  before_action :set_new_csrf_token
  before_action do
    year_created = '2023'
    year = Date.current.year.to_s

    @year = year == year_created ? year : "#{year_created} - #{year}"
  end

  def authorize_user
    raise DomainErrors::User::AuthorizationError if current_user.nil?
  rescue DomainErrors::User::AuthorizationError
    reset_session
  ensure
    redirect_to_login if @current_user.nil?
  end

  protected

  def session_token
    return session[:token] if session && session[:token]

    session_store = Rails.application.config.session_store.new(
      Rails.application,
      Rails.application.config.session_options
    )
    id = request.headers['X-Auth-ID']
    session_store.send(:find_session, request.env, id).last[:token]
  end

  def current_user
    @current_user ||= DomainServices::User::AuthorizationService.call(session_token)
  rescue StandardError
    nil
  end

  def redirect_to_login
    respond_to do |format|
      format.html { redirect_to auth_url }
      format.json { render json: { error: 'Not Authorized' }, status: :unauthorized }
    end
  end

  private

  def wrap_in_error_handler(&block)
    with_http_error_handling(&block)
  end

  def set_new_csrf_token
    return unless protect_against_forgery?
    return unless request.format.json?

    response.headers['X-CSRF-Token'] = form_authenticity_token
  end
end
