class Api::V1::RequestsController < Api::V1::BaseController
  before_action :set_user, only: [:request_update, :request_index]
  before_action :set_requester, only: :create
  before_action only: [:create, :request_update] do |c|
  meth = c.method(:validate_json) 
  meth.call (@json.has_key?('request') && @json['request'].respond_to?(:[]) && @json['request']['requestee_id'] && @json['request']['requester_id'])
 end

 before_action only: :request_index do |c|
  meth = c.method(:validate_json) 
  meth.call (@json.has_key?('request') && @json['request'].respond_to?(:[]) && @json['request']['requestee_id'])
 end


  def request_index
    @users = @user.requesters.where('requests.accepted = ?', false)
    render json: @users.map {|user| Api::V1::UserSerializer.new(user).as_json}
  end

  
  def create
    @friend_request = @user.sent_requests.build(@json['request'])
    if @friend_request.save
      render json: { message: 'Friend request sent!' }, status: :ok
    else
      render json: { message: 'Friend request was not sent!' }, status: :unauthorized
    end
  end



  def request_update
    @friend_request = Request.get_request_confirm(@json['request']['requester_id'], @json['request']['requestee_id'])
    @friend_request.first.accept
    @user.friends.create(otheruser_id: @friend_request.first.requester_id)
    @profile = FinderService.find_resource(User, @friend_request.first.requester_id).profile
    render json: {profile: Api::V1::ProfileSerializer.new(@profile).as_json}, status: :ok
  end

  private

  def set_user
    @user = FinderService.find_resource(User, @json['request']['requestee_id'])
    render nothing: true, status: :bad_request unless @user
  end

  def set_requester
    @user = FinderService.find_resource(User, @json['request']['requester_id'])
    render nothing: true, status: :bad_request unless @user
  end

end
