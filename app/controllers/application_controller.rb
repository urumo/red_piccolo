# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def authorize_user
    begin
      @current_user = DomainServices::User::AuthorizationService.call(request.headers['Authorization'] ||
                                                                        auth_cookie)
    rescue DomainErrors::User::AuthorizationError
      cookies.delete(:Authorization)
      session[:user_id] = nil
      nil
    end

    redirect_to_login if @current_user.nil?
  end

  protected

  def current_user_token
    token_header = request.headers['Authorization']

    return 'Session not found' if token_header.nil?

    token_header.split(' ').last
  end

  def auth_cookie
    JSON.parse(request.cookies['Authorization'])['value']['token']
  end

  def redirect_to_login
    respond_to do |format|
      format.html { redirect_to auth_url }
      format.json { render json: { error: 'Not Authorized' }, status: :unauthorized }
    end
  end
end
