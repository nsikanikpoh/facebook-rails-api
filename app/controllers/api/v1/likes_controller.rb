class Api::V1::LikesController < Api::V1::BaseController

  before_action only: :create do |c|
  meth = c.method(:validate_json) 
  meth.call (@json.has_key?('like') && @json['like'].respond_to?(:[]) && @json['like']['like_id'])
 end


  before_action only: :destroy do |c|
  meth = c.method(:check_existence)
  meth.call(@like, "Like", "find(@json['like']['id'])")
end


  # like /likes
  # like /likes.json
  def create
    @like = current_user.likes.build(@json['like'])
    if @like.save
      render json: { message: 'You liked this Post!' }, status: :ok
    else
      render json: { message: 'Like did not work' }, status: :unauthorized
    end
  end



    def destroy
    if @like.present?
       @like.destroy
       render json: { message: 'Like was successfully destroyed.' }, status: :ok
    else
       render nothing: true, status: :not_exist
   end
  end


end
