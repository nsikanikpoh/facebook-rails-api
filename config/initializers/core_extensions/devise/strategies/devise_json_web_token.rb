module Devise
  module Strategies
    class JWTAuthentication < Base
      @request_object = nil
      def self.valid?(request)
        @request_object = request if request.headers['Authorization']&.to_s
      end

      def authenticate!
        return if no_claims_or_no_claimed_user_id
        success! User.find(claims['user_id'])
      end

      protected
      
      def no_claims_or_no_claimed_user_id
        !claims || !claims.has_key?('user_id')
      end

      private

      def claims
        strategy, token = @request_object.headers['Authorization'].to_s.split(' ')
        return nil if (strategy || '').downcase != 'bearer'
        WebToken.decode(token) rescue nil
      end
    end
  end
end
