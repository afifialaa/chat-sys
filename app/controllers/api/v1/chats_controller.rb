class Api::V1::ChatsController < ApplicationController

    skip_before_action :verify_authenticity_token

    before_action :set_application
    before_action :set_chat, only: %i[ show update destroy ]

    def index
        @application.chats
    end

    def create
        @application = Application.find_by(token: params[:token])

        if @application == nil 
            render(json: {"error": "application not found"}, status: :not_found)
        else
            chats_count = @application.chats.count

            @chat = @application.chats.create()

            if @chat == nil
                render(json: {"error": "failed to create chat"}, status: :internal_server_error)
            else
                render(json: {"number": @chat.number}, status: :created)
            end

            
        end
    end

    def delete
        @application = Application.find_by(token: params[:token])
        @chat = @application.chats.find_by(number: params[:chat_number])

        if @chat == nil
           return render(json: {"error": "chat not found"} , status: :not_found)
        elsif @chat.destroy
            return render(json: {} , status: :ok)
        else
            return render(json: {} , status: :internal_server_error)
        end
    end

    def show
        @application = Application.find_by(token: params[:token])
        @chat = @application.chats.find_by(number: params[:number])
        if @chat == nil
            render(json: {} , status: :not_found)
        else
            render(json: @chat.as_json(:except => :id) , status: :ok)
        end

    end

    private
    
    def chat_params
        params.permit(:number)
    end
end
