class Api::V1::MessagesController < ApplicationController

    skip_before_action :verify_authenticity_token

    def index
        @application = Application.find_by(token: params[:token])
        @chat = Application.chats.find_by(number: params[:number])
        @messages = @chat.messages
    end

    def create
        @application = Application.find_by(token: params[:token])
        if @application == nil 
            render(json: {msg: "application not found"}, status: :not_found)
            return
        end
        # @chat = @application.chats.find_by(number: params[:number])
        @chat = @application.chats.find(params[:number])
        if @chat == nil 
            render(json: {msg: "chat not found"}, status: :not_found)
            return
        end

        @message = @chat.messages.create(content: params[:content], number: 4)

        # update messages_count column
        messages_count = @chat.messages.count
        @chat.update(messages_count: messages_count)

        if @message
            render(json: {"number": @message.number}, status: :created)
        else
            render(json: {}, status: :internal_server_error)
        end
    end

    def delete
        @application = Application.find_by(token: params[:token])
        # @chat = @application.chats.find_by(number: params[:chat_number])
        @chat = @application.chats.find(params[:chat_number])
        # @message = @chat.messages.find_by(number: params[:message_number])
        @message = @chat.messages.find(params[:message_number])

        if @message.destroy
            render(json: {}, status: :ok)
        else
            render(json: {}, status: :internal_server_error)
        end
    end
    
    def update
        @application = Application.find_by(token: params[:token])
        # @chat = @application.chats.find_by(number: params[:chat_number])
        @chat = @application.chats.find(params[:chat_number])
        # @message = @chat.messages.find_by(number: params[:message_number])
        @message = @chat.messages.find(params[:message_number])

        if @message.update(message_params)
            render(json: {}, status: :ok)
        else
            render(json: {}, status: :internal_server_error)
        end
    end

    def show
        @application = Application.find_by(token: params[:token])
        # @chat = @application.chats.find_by(number: params[:chat_number])
        @chat = @application.chats.find(params[:chat_number])
        # @message = @chat.messages.find_by(number: params[:message_number])
        @message = @chat.messages.find(params[:message_number])

        render(json: @message.as_json(:except => :id), status: :internal_server_error)
    end

    def partial_search
        @application = Application.find_by(token: params[:token])
        #@chat = @application.chats.find_by(number: params[:chat_number])
        @chat = @application.chats.find(params[:chat_number])

        @message = Message.partial_search(params[:query], 10)
        puts @message

        render(json: {"msg": @message}, status: :ok)
    end

    private
    
    def message_params
        params.permit(:content)
    end
end
