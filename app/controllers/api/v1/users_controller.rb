class Api::V1::UsersController < Api::V1::BaseController

  def index
    @users = User.where('id != ?', current_user.id)
    render json: @users.map {|user| Api::V1::UserSerializer.new(user).as_json}
  end

  def search
    if params[:search].blank?
      render json: { error: 'invalid_search' }, status: :unauthorized
    else
      @users = User.search(params[:search].downcase)
      render json: @users.map {|user| Api::V1::UserSerializer.new(user).as_json}
    end
end

end
