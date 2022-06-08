class Api::V1::ChatsController < ApplicationController

    skip_before_action :verify_authenticity_token

    before_action :set_application
    before_action :set_chat, only: [:delete, :show, :update]

    def index
        @application.chats
    end

    def create
        @chat = @application.chats.create()

        if @chat == nil
            render(json: {"error": "failed to create chat"}, status: :internal_server_error)
        else
            render(json: {"number": @chat.number}, status: :created)
        end
    end

    def delete
        if @chat.destroy
            return render(json: {} , status: :ok)
        else
            return render(json: {} , status: :internal_server_error)
        end
    end

    def show
        render(json: @chat.as_json(:except => :id) , status: :ok)
    end

    private
    
    def chat_params
        params.permit(:number)
    end
end
