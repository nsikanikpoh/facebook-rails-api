class Api::V1::RequestsController < Api::V1::BaseController

  before_action only: :create do |c|
  meth = c.method(:validate_json) 
  meth.call (@json.has_key?('request') && @json['request'].respond_to?(:[]) && @json['request']['requestee_id'])
 end

  before_action only: :update do |c|
  meth = c.method(:validate_json)
  meth.call (@json.has_key?('request'))
 end

 before_action only: :update do |c|
  meth = c.method(:check_existence)
  meth.call(@friend_request, "Request", "find(@json['request']['id'])")
 end

  # GET /requests
  # GET /requests.json
  def index
    @users = current_user.requesters.where('requests.accepted = ?', 0)
    render json: @users.map {|user| Api::V1::UserSerializer.new(user).as_json}
  end

  # POST /requests
  # POST /requests.json
  def create
    @friend_request = current_user.sent_requests.build(@json[:request])
    if @friend_request.save
      render json: { message: 'Friend request sent!' }, status: :ok
    else
      render json: { message: 'Friend request was not sent!' }, status: :unauthorized
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    @friend_request.accept
    @profile = User.find(@json[:request][:requester_id]).profile
    render json: {profile: Api::V1::ProfileSerializer.new(@profile).as_json, mesage: 'Friend Request Accepted!'} status: :ok
  end




end
