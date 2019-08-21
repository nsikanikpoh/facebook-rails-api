class Api::V1::CommentsController < Api::V1::BaseController
  before_action :set_comment_user, only: [:create, :comment_delete]
  before_action :set_comment, only: [:comment_delete, :update]

  before_action only: :create do |c|
  meth = c.method(:validate_json) 
  meth.call (@json.has_key?('comment') && @json['comment'].respond_to?(:[]) && @json['comment']['post_id'] && @json['comment']['content'] && @json['comment']['user_id'])
 end

  before_action only: :update do |c|
  meth = c.method(:validate_json)
  meth.call (@json.has_key?('comment'))
 end

 def update
    if @comment.present?
      authorize(@comment)
      update_values :@comment, @json['comment']
   else
     render nothing: true, status: :not_exist
   end
  end

   def comment_delete
    if @comment.present?
      authorize(@comment)
      @comment.destroy
     render nothing: true, status: :ok
   else
     render nothing: true, status: :not_exist
   end
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @user.comments.build(@json['comment'])
    update_values :@comment, @json['comment']
  end


  private


   def set_comment
     @comment = FinderService.find_resource(Comment, @json['comment']['id'])
     render nothing: true, status: :bad_request unless @comment
   end
   def set_comment_user
     @user = FinderService.find_resource(User, @json['comment']['user_id'])
     render nothing: true, status: :bad_request unless @user
  end

  def authorize(comment)
      render json: { error: 'invalid_credentials' }, status: :unauthorized unless comment.user == set_comment_user
   end

end
