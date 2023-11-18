# frozen_string_literal: true

class UserController < ApplicationController
  before_action :authorize_user, except: %i[login register auth id]
  before_action :user, only: [:id]
  before_action :redirect_to_root, only: %i[auth login register]

  def index
    @user = @current_user
    @editable = ''
  end

  def logout
    session[:token] = nil
    cookies[:Authorization] = nil
    redirect_to root_path
  end

  def login
    token = DomainServices::User::LoginService.call(params[:email], params[:password])
    respond_to do |format|
      format.html do
        session[:token] = token
        pp session
        cookies[:Authorization] = { value: token, expires: 1.day.from_now }.to_json
        redirect_to root_path
      end
      format.json { render json: { token: token }, status: :ok }
    end
  end

  def register; end

  def id
    @editable = 'readonly'
  end

  def block; end

  def settings; end

  def auth
    redirect_to root_path if @current_user
  end

  private

  def editable = @editable ? '' : 'readonly'

  def user = @user ||= User.find(params[:id])

  def redirect_to_root
    redirect_to root_path if session[:user_id].present?
  end
end
