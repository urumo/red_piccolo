# frozen_string_literal: true

class ChatController < ApplicationController
  before_action :authorize_user
  attr_reader :presenter

  delegate :result, to: :presenter

  def create
    @presenter = Presenters::Chat::CreateChatPresenter.new(current_user, params[:title], params[:description])
    render json: result, status: :created
  end

  def update
    chat = DomainServices::Chat::EditChatService
           .call(current_user, params[:id], params[:title], params[:description])
    render json: chat, status: :ok
  end

  def show
    @presenter = Presenters::Chat::ShowPresenter.new(current_user.id)
    render json: result, status: :ok
  end

  def send_message; end

  def destroy
    chat = DomainServices::Chat::DeleteChatService.call(current_user, params[:id])
    render json: chat, status: :ok
  end
end
