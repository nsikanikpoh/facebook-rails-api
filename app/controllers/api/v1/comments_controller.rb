class Api::V1::CommentsController < Api::V1::BaseController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :check_if_author, only: [:edit, :update, :destroy]

  # POST /comments
  # POST /comments.json
  def create
    current_user = User.find(params[:comment][:user_id])
    @comment = current_user.comments.build(comment_params)
    super
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :user_id, :post_id)
    end
end
