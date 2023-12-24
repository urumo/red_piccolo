module Presenters

  module Chat

    class CreateChatPresenter < ApplicationPresenter
      attr_reader :title, :description, :current_user

      def initialize(current_user, title, description)

        @current_user = current_user

        @title = title

        @description = description
        super()
      end

      def result
        chat.as_dto
      end

      private

      def chat = DomainServices::Chat::CreateChatService
                   .call(current_user, title, description)
    end

  end

end