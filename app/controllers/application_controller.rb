# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def authorize_user
    @current_user = begin
      DomainServices::User::AuthorizationService.call(request.headers['Authorization'])
    rescue JWT::DecodeError => _e
      nil
    end

    redirect_to_login if @current_user.nil?
  end

  protected

  def redirect_to_login
    respond_to do |format|
      # format.html { redirect_to auth_url }
      format.json { render json: { error: 'Not Authorized' }, status: :unauthorized }
    end
  end
end
