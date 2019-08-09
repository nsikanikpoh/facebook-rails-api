class Api::V1::SessionsController < ApplicationController
  respond_to :json
   before_action :verify_jwt_token, except: :create

    def show
       current_user = User.find(params[:user_id])
       current_user ? head(:ok) : head(:unauthorized)
    end

    def create
      @user = User.where(email: params[:email]).first
      if @user&.valid_password?(params[:password])
        jwt = WebToken.encode(@user)
        render json:  { token: jwt, user: @user}, status: :created
      else
        render json: { error: 'invalid_credentials' }, status: :unauthorized
      end
    end

  def forgot_password
    resource = User.with_email(params[:email]).first
    Api::V1::CustomDeviseMailer.reset_password_instructions(  resource, token).deliver
    head :ok
  end

  

end
