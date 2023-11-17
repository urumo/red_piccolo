# frozen_string_literal: true

module ApplicationCable
  module Chat
    class MessagesChannel < ApplicationCable::Channel
      def subscribed
        # stream_from "some_channel"
      end

      def unsubscribed
        # Any cleanup needed when channel is unsubscribed
      end
    end
  end
end
