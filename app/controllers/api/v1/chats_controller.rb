class Api::V1::ChatsController < ApplicationController

    skip_before_action :verify_authenticity_token

    def index
        @application = Application.find_by(token: params[:token])
        @application.chats
    end

    def create
        @application = Application.find_by(token: params[:token])

        if @application == nil 
            render(json: {"error": "application not found"}, status: :not_found)
        else
            chats_count = @application.chats.count

            @chat = @application.chats.create(number: chats_count+1)

            if @chat == nil
                render(json: {"error": "failed to create chat"}, status: :internal_server_error)
            else
                # udpate chats_count column
                chats_count = @application.chats.count
                @application.update(chats_count: chats_count)

                render(json: {"number": @chat.number}, status: :created)
            end

            
        end
    end

    def delete
        @application = Application.find_by(token: params[:token])
        @chat = @application.chats.find_by(numnber: params[:number])
        if @chat.destroy
            @application.chats_count = @application.chats_count - 1
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
