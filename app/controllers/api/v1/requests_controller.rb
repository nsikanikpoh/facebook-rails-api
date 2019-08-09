class Api::V1::RequestsController < Api::V1::BaseController

  # GET /requests
  # GET /requests.json
  def index
    @users = current_user.requesters.where('requests.accepted = ?', 0)
    render json: @users.map {|user| Api::V1::UserSerializer.new(user).as_json}
  end

  # POST /requests
  # POST /requests.json
  def create
    current_user = User.find(params[:request][:requestee_id])
    @friend_request = current_user.sent_requests.build(request_params)
    if @friend_request.save
      render json: { message: 'Friend request sent!' }, status: :ok
    else
      render json: { message: 'Friend request was not sent!' }, status: :unauthorized
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    @friend_request = Request.find(params[:id])
    @friend_request.accept
    @profile = User.find(params[:request][:requester_id]).profile
      render json: {profile: Api::V1::ProfileSerializer.new(@profile).as_json, mesage: 'Friend Request Accepted!'} status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
       params.require(:request).permit(:requestee_id)
  end
end
