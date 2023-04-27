class Api::V1::SessionsController < ApplicationController
  def create
    resource = User.where('lower(email) = ?', params[:email].try(:downcase).try(:strip)).first
    if resource && resource.password == Digest::SHA256.hexdigest(params[:password])
      render json: resource
    else
      render status: :unauthorized, json: { errors: ["Email and password don't match"] }
    end
  end
end
