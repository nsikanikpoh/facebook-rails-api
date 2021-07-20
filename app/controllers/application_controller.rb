class ApplicationController < ActionController::API
 before_action :verify_jwt_token
 
#jwt token verification
 def verify_jwt_token
 	head :unauthorized if request.headers['Authorization'].nil? || 
 	!current_user
 end

 def current_user
 	Devise::Strategies::JWTAuthentication.valid?(request)
 end

end
