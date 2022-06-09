class Api::V1::ApplicationsController < ApplicationController

    skip_before_action :verify_authenticity_token

    before_action :set_application, only: [:delete, :show, :update]

    def create
        @application = Application.new(application_params)
        if @application.save
            render(json: {token: @application.token} , status: :created)
        else
            render(json: {} , status: :internal_server_error)
        end
    end

    def delete
        if @application.lock!.destroy
            render(json: {} , status: :ok)
        else
            render(json: {} , status: :internal_server_error)
        end
    end

    def show
        render(json: @application.as_json(:except => :id), status: :ok)
    end

    def update
        if @application.lock!.update(application_params)
            render(json: @application.as_json(:except => :id), status: :ok)
        else
            render(json: {}, status: :internal_server_error)
        end
    end


    private
    def application_params
        params.permit(:name, :token)
    end
end
