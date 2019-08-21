class Api::V1::UsersController < Api::V1::BaseController
  before_action only: :search do |c|
  meth = c.method(:validate_json)
  meth.call (@json.has_key?('search'))
 end

 before_action only: :users_index do |c|
  meth = c.method(:validate_json)
  meth.call (@json.has_key?('user_id'))
 end

  def users_index
    @user = FinderService.find_resource(User, @json['user_id'])
    render nothing: true, status: :bad_request unless @user
    @users = User.where('id != ?', @user.id)
    render json: @users.map {|user| Api::V1::UserSerializer.new(user).as_json}
  end

  def search
    if @json['search'].blank?
      render json: { error: 'invalid_search' }, status: :unauthorized
    else
      @users = User.search(@json['search'].downcase)
      render json: @users.map {|user| Api::V1::UserSerializer.new(user).as_json}
    end
  end



end
