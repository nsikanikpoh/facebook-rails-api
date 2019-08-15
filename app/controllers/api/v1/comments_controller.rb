class Api::V1::CommentsController < Api::V1::BaseController

  before_action only: :create do |c|
  meth = c.method(:validate_json) 
  meth.call (@json.has_key?('comment') && @json['comment'].respond_to?(:[]) && @json['comment']['post_id'] && @json['comment']['content'] && @json['comment']['user_id'])
 end

  before_action only: :update do |c|
  meth = c.method(:validate_json)
  meth.call (@json.has_key?('comment'))
 end

  before_action only: [:update, :destroy] do |c|
  meth = c.method(:check_existence)
  meth.call(@comment, "Comment", "find(@json['comment']['id'])")
 end

 def update
    if @comment.present?
      authorize(@comment)
      update_values :@comment, @json['comment']
   else
     render nothing: true, status: :not_exist
   end
  end


   def destroy
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
    @user = User.find(@json['comment']['user_id'])
    @comment = @user.comments.build(@json['comment'])
    update_values :@comment, @json['comment']
  end

  private


  def authorize(comment)
      render json: { error: 'invalid_credentials' }, status: :unauthorized unless comment.user == current_user
   end

end
