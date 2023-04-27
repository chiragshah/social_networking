class Api::V1::BaseController < ApplicationController
	include ActionController::HttpAuthentication::Token::ControllerMethods
	include ActionController::Serialization

	before_action :authenticate

	private 

	def authenticate
		authenticate_or_request_with_http_token do |token, options|
			@current_user = User.find_by(auth_token: token)
      if @current_user
        return @current_user
      end
    end
	end
end
