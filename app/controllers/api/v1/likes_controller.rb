class Api::V1::LikesController < Api::V1::BaseController

  # POST /likes
  # POST /likes.json
  def create
    current_user = User.find(params[:like][:user_id])
    @like = current_user.likes.build(like_params)
    if @like.save
      render json: { message: 'You liked this post!' }, status: :ok
    else
      render json: { message: 'Like did not work' }, status: :unauthorized
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def like_params
      params.require(:like).permit(:post_id, :user_id)
    end
end
