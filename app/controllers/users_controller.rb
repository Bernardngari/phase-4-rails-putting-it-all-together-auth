class UsersController < ApplicationController

	def create
		user = User.create(user_params)
		if user.valid?
		session[:user_id] = user.id
			render json: user,only: [:id, :username,:image_url, :bio] ,status: :created
		else
			render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
		end
	end

	def show
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      render json: user,only: [:id,:username, :image_url, :bio] ,status: :ok
    else
      render json: {error: "Not authorized"}, status: :unauthorized
    end
	end

	private
	def user_params
		params.permit(:username,:password, :password_confirmation,:bio, :image_url)
	end
end
