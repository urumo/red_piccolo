# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Modules::HttpErrorHandler
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info

  def authorize_user
    with_http_error_handling do
      raise DomainErrors::User::AuthorizationError if current_user.nil?
    rescue DomainErrors::User::AuthorizationError
      reset_session
    ensure
      redirect_to_login if @current_user.nil?
    end
  end

  protected

  def session_token
    session_store = Rails.application.config.session_store.new(
      Rails.application,
      Rails.application.config.session_options
    )
    id = request.headers['X-Auth-ID']
    session_store.send(:find_session, request.env, id).last[:token] || session[:token]
  end

  def current_user
    @current_user = DomainServices::User::AuthorizationService.call(session_token)
  rescue StandardError
    nil
  end

  # @deprecated
  def current_user_token
    token_header = request.headers['Authorization']
    return nil if token_header.nil?

    token_header.split(' ').last
  end

  def redirect_to_login
    respond_to do |format|
      format.html { redirect_to auth_url }
      format.json { render json: { error: 'Not Authorized' }, status: :unauthorized }
    end
  end
end
