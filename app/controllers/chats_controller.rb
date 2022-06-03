class ChatsController < ApplicationController

    skip_before_action :verify_authenticity_token

    def index
        @application = Application.find_by(token: params[:token])
        @application.chats
    end

    def create
        @application = Application.find_by(token: params[:token])

        if @application == nil 
            render(json: {}, status: :not_found)
        else
            @application.chats.create(number: params[:number])
            render(json: {}, status: :created)
        end
    end

    def delete
        @application = Application.find_by(token: params[:token])
        @chat = @application.chats.find_by(numnber: params[:number])
        if @chat.destroy
            render(json: {} , status: :ok)
        elsif @chat == nil
            render(json: {} , status: :not_found)
        else
            render(json: {} , status: :internal_server_error)
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
