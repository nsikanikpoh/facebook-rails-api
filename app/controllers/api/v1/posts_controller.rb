class Api::V1::PostsController < Api::V1::BaseController
  # GET /posts
  # GET /posts.json
  def index
    current_user = User.find(params[:user_id])
    @posts = Post.friends_posts(current_user)
    render json: @posts.map {|post| Api::V1::PostSerializer.new(post).as_json}
  end

  # POST /posts
  # POST /posts.json
  def create
    current_user = User.find(params[:post][:user_id])
    @post.user = current_user
    super
  end

  private


    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :image, :user_id)
    end
end
