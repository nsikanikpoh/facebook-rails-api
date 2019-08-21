class Api::V1::BaseController < ApplicationController
   respond_to :json
   before_action :parse_request
   before_action :verify_jwt_token

   def validate_json(condition)
     unless condition
       render nothing: true, status: :bad_request
     end
   end

	def update_values(ivar, attributes)
	  instance_variable_get(ivar).assign_attributes(attributes)
	  if instance_variable_get(ivar).save
	    render nothing: true, status: :ok
	  else
	    render nothing: true, status: :bad_request
	  end
	end


    private

       def parse_request
         @json = JSON.parse(request.body.read)
       end

end
