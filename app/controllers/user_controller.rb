# frozen_string_literal: true

class UserController < ApplicationController
  before_action :authorize_user, except: %i[login register auth id]
  before_action :user, only: %i[id index block]
  before_action :redirect_to_root, only: %i[auth login register]
  before_action :set_editable, only: %i[index id]

  def index
    with_http_error_handling do
      @user = @current_user
    end
  end

  def logout
    with_http_error_handling do
      reset_session
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json { render json: { status: :ok }, status: :ok }
      end
    end
  end

  def login
    with_http_error_handling do
      generate_jwt
    end
  end

  def register
    with_http_error_handling do
      DomainServices::User::RegisterService.call(params[:email], params[:password], params[:password_confirmation])
      generate_jwt
    end
  end

  def id; end

  def block; end

  def settings
    with_http_error_handling do
      update_user_settings(params)
      change_password(params)
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json { render json: { status: :ok }, status: :ok }
      end
    end
  end

  def auth
    with_http_error_handling do
      redirect_to_root
    end
  end

  private

  def update_user_settings(params)
    DomainServices::User::AddUserDatumService.call(@current_user,
                                                   params[:first_name],
                                                   params[:last_name],
                                                   params[:date_of_birth])
  end

  def user
    @user = if request.path.include?('id/')
              User.find(params[:id])
            else
              @current_user
            end
  end

  def redirect_to_root
    redirect_to(root_path(id: session.id)) if session[:token].present?
  end

  def set_editable
    @editable = @current_user.id == @user.id
  end

  def change_password(params)
    return if params[:old_password].blank?

    DomainServices::User::ChangePasswordService.call(@current_user,
                                                     params[:old_password],
                                                     params[:new_password],
                                                     params[:new_password_confirmation])
  end

  def generate_jwt
    token = DomainServices::User::LoginService.call(params[:email], params[:password])
    respond_to do |format|
      format.html do
        session[:token] = token
        redirect_to_root
      end
      format.json { render json: { token: }, status: :ok }
    end
  end
end
