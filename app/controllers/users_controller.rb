class UsersController < ApplicationController

    before_action :authorize, only: [:show]

    def create
        signup = User.create!(user_params)
        session[:user_id] = signup.id
        render json: signup, status: :created
    end

    def show
        render json: @current_user
    end

    private

    def user_params
        params.permit(:username, :image_url, :bio, :password, :password_confirmation)
    end

    def authorize
        return render json: { error: "not authorized" }, status: :unauthorized unless session.include? :user_id
    end

end
