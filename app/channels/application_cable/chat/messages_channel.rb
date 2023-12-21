# frozen_string_literal: true

module ApplicationCable
  module Chat
    class MessagesChannel < ApplicationCable::Channel
      def subscribed
        Rails.logger.debug params
        @user = User.find(params[:user_id])
        stream_for "messages_#{@user.id}"
      end

      def unsubscribed
        Rails.logger.debug params
      end
    end
  end
end
