# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def authorize_user
    @current_user = DomainServices::User::AuthorizationService.call(request.headers['Authorization'])
  end
end
