class Api::V1::MessagesController < ApplicationController

    skip_before_action :verify_authenticity_token
    before_action :set_application
    before_action :set_chat

    def index
        @messages = @chat.messages
    end

    def create
        @message = @chat.messages.create(content: params[:content])

        if @message
            render(json: {"number": @message.number}, status: :created)
        else
            render(json: {}, status: :internal_server_error)
        end
    end

    def delete
        @message = @chat.messages.find_by(number: params[:message_number])

        if @message == nil
            render(json: {"error": "message not found" }, status: :not_found)
            return
        end

        if @message.destroy
            render(json: {}, status: :ok)
        else
            render(json: {}, status: :internal_server_error)
        end
    end
    
    def update
        @message = @chat.messages.find_by(number: params[:message_number])

        if @message.update(message_params)
            render(json: {}, status: :ok)
        else
            render(json: {}, status: :internal_server_error)
        end
    end

    def show
        @message = @chat.messages.find(params[:message_number])

        render(json: @message.as_json(:except => :id), status: :internal_server_error)
    end

    def partial_search
        @message = Message.partial_search(params[:query], @chat.id)

        render(json: {"result": @message}, status: :ok)
    end

    private
    
    def message_params
        params.permit(:content)
    end
end
