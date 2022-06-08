class ApplicationController < ActionController::Base

    private

    def set_application
        @application = Application.find_by(token: params[:token])
        if @application == nil
          render(json: {"error": "application not found"} , status: :not_found)
        end
    end

    def set_chat
        @chat = @application.chats.find_by(number: params[:chat_number])
        if @chat == nil
          render( json: {"error": "chat not found"}, status: :not_found)
        end
    end

end
