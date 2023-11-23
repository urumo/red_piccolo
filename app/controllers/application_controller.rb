# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def authorize_user
    begin
      token = request.headers['Authorization'] || auth_cookie || session[:token]
      @current_user = DomainServices::User::AuthorizationService.call(token)
    rescue DomainErrors::User::AuthorizationError
      cookies.signed.encrypted[:token] = nil
      session[:token] = nil
      nil
    end

    redirect_to_login if @current_user.nil?
  end

  protected

  def current_user_token
    token_header = request.headers['Authorization']
    return nil if token_header.nil?

    token_header.split(' ').last
  end

  def auth_cookie
    cookie = cookies.signed.encrypted[:token]
    @auth_cookie ||= JSON.parse(cookie)['value'] unless cookie.nil?
  end

  def redirect_to_login
    respond_to do |format|
      format.html { redirect_to auth_url }
      format.json { render json: { error: 'Not Authorized' }, status: :unauthorized }
    end
  end
end
