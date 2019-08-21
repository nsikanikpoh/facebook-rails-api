class Api::V1::LikesController < Api::V1::BaseController

  before_action do |c|
  meth = c.method(:validate_json) 
  meth.call (@json.has_key?('like') && @json['like'].respond_to?(:[]) && @json['like']['user_id'] && @json['like']['post_id'])
 end

  # like /likes
  # like /likes.json
  def create
    @user = User.find(@json['like']['user_id'])
    @like = @user.likes.build(@json['like'])
    if @like.save
      render json: { message: 'You liked this Post!' }, status: :ok
    else
      render json: { message: 'Like did not work' }, status: :unauthorized
    end
  end


  def like_delete
    @likes = Like.post_user_like(@json['like']['user_id'], @json['like']['post_id'])
    if @likes.present?
       @likes[0].destroy
       render json: { message: 'Like was successfully destroyed.' }, status: :ok
    else
       render nothing: true, status: :not_exist
   end
  end

end
