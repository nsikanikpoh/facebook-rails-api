class Api::V1::ProfilesController < Api::V1::BaseController
  before_action :set_profile, only: [:show, :edit, :update]

  # GET /profiles/1
  # GET /profiles/1.json
  def show
   @profile ||= Profile.find(params[:id])
    @posts = @profile.user.posts
    render json: {posts: @posts.map {|post| Api::V1::PostSerializer.new(post).as_json},
          profile: Api::V1::ProfileSerializer.new(@profile).as_json}
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:birthday, :gender, :location, :bio, :avatar, :cover, :user_id)
    end
end
