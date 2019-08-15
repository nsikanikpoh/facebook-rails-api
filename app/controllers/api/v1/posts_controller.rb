class Api::V1::PostsController < Api::V1::BaseController
  skip_before_action :parse_request, only: :index

  before_action only: :create do |c|
  meth = c.method(:validate_json) 
  meth.call (@json.has_key?('post') && @json['post'].respond_to?(:[]) && @json['post']['content'] && @json['post']['user_id'])
 end

  before_action only: :update do |c|
  meth = c.method(:validate_json)
  meth.call (@json.has_key?('post'))
 end

  before_action only: [:show, :destroy, :update] do |c|
  meth = c.method(:check_existence)
  meth.call(@post, "Post", "find(@json['post']['id'])")
end

 before_action :set_post_user, only: [:post_index, :create]

 def create
     @post = @user.posts.build(@json['post'])
     update_values :@post, @json['post']
 end


  def update
    if @post.present?
      authorize(@post)
      update_values :@post, @json['post']
   else
     render nothing: true, status: :not_exist
   end
  end


   def destroy
    if @post.present?
      authorize(@post)
      @post.destroy
     render nothing: true, status: :ok
    else
     render nothing: true, status: :not_exist
    end
  end

  # GET /posts
  # GET /posts.json
  def post_index
    @posts = Post.all
    render json: @posts.map {|post| Api::V1::PostSerializer.new(post).as_json}
  end

  def show 
  end

  private

    def set_post_user
      @user = User.find(params['post']['user_id'])
    end

    def authorize(post)
     render json: { error: 'invalid_credentials' }, status: :unauthorized unless post.user == current_user
    end
   
   
end
