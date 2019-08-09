class Api::V1::RegistrationsController < ApplicationController
  respond_to :json
  before_action :verify_jwt_token, except: :create

  respond_to :json

  def create
    @user = User.new(sign_up_params)
    if @user.save && @user.valid?
      head(:ok)
    else
      render json: { error: 'invalid_credentials' }, status: :unauthorized
    end
  end


  def update
    @user = current_user
    if @user.update_attributes(sign_up_params) && @user.valid?
      render(json: Api::V1::UserSerializer.new(@user).to_h.merge(status: 200))
    else
      render(json: Api::V1::UserSerializer.new(@user).to_h.merge(status: 400))
    end
  end

  def destroy
    resource = current_user
    resource.destroy
    head :ok
  end


  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end

end
