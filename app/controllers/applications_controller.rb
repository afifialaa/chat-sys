class ApplicationsController < ApplicationController

    skip_before_action :verify_authenticity_token

    def create
        @application = Application.new(application_params)
        if @application.save
            head 201
        else
            head 500
        end
    end

    def delete
        @application = Application.find_by(token: params[:token])
        if @application == nil
            head :not_found
        elsif @application.destroy
            head :ok
        else
            head :internal_server_error
        end
    end

    def show
        @application = Application.find_by(token: params[:token])
        if @application == nil
            render(json: {} , status: :not_found)
        else
            render(json: @application , status: :ok)
        end
    end

    def update
        @application = Application.find_by(token: params[:token])
        if @application == nil
            render(json: {}, status: :not_found)
        elsif @application.update(application_params)
            render(json: @application, status: :ok)
        else
            render(json: {}, status: :internal_server_error)
        end
    end


    private
    def application_params
        params.permit(:name)
    end
end
