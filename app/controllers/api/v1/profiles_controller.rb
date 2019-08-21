class Api::V1::ProfilesController < Api::V1::BaseController
  before_action :set_profile
  before_action :set_user, only: :show_profile

  before_action only: :update do |c|
  meth = c.method(:validate_json) 
  meth.call (@json.has_key?('profile') && @json['profile'].respond_to?(:[]) && @json['profile']['user_id'] && @json['profile']['gender'] && @json['profile']['location'] && @json['profile']['bio'] && @json['profile']['birthday'] && @json['profile']['cover'] && @json['profile']['avatar'])
 end

  before_action only: :show_profile do |c|
  meth = c.method(:validate_json) 
  meth.call (@json.has_key?('profile') && @json['profile'].respond_to?(:[]) && 
    @json['profile']['user_id'])
 end

  def show_profile
    if @profile.present?
       @posts = @user.posts
       render json: {posts: @posts.map {|post| Api::V1::PostSerializer.new(post).as_json},
          profile: Api::V1::ProfileSerializer.new(@profile).as_json}
    else
     render nothing: true, status: :not_exist
    end
  end


  def update
    if @profile.present?
       @profile.update_attributes(@json['profile'])
       @posts = @user.posts
       render json: {posts: @posts.map {|post| Api::V1::PostSerializer.new(post).as_json},
          profile: Api::V1::ProfileSerializer.new(@profile).as_json}
    else
     render nothing: true, status: :not_exist
   end
  end


   private


   def set_profile
     set_user
     @profile = @user.profile
     render nothing: true, status: :bad_request unless @profile
   end

   def set_user
     @user = FinderService.find_resource(User, @json['profile']['user_id'])
     render nothing: true, status: :bad_request unless @user
  end
end
