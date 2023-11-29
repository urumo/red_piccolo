# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Modules::HttpErrorHandler
  add_flash_types :success, :warning, :danger, :info

  def authorize_user
    with_http_error_handling do
      raise DomainErrors::User::AuthorizationError if current_user.nil?
    rescue DomainErrors::User::AuthorizationError
      session[:token] = nil
    ensure
      redirect_to_login if @current_user.nil?
    end
  end

  protected

  def current_user
    token = request.headers['Authorization'] || session[:token]

    @current_user = DomainServices::User::AuthorizationService.call(token)
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
