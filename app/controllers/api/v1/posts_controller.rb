class Api::V1::PostsController < Api::V1::BaseController
  before_action :set_resource, only: [:show, :update, :destroy]

  def index
    render json: @current_user.posts
  end

  def create
    resource = @current_user.posts.new(permitted_params)
    if resource.save
      render json: resource
    else
      full_resource_errors(resource)
    end
  end

  def update
    if @resource.update(permitted_params)
      render json: @resource
    else
      full_resource_errors(@resource)
    end
  end

  def show
    render json: @resource
  end

  def destroy
    if @resource.destroy
      render status: :ok
    else
      full_resource_errors(@resource)
    end
  end

  private

  def set_resource
    @resource = @current_user.posts.find(params[:id])
    render status: :not_found, json: { errors: "Post not found" } unless @resource
  end

  def permitted_params
    params.require(:post).permit(:body, :all_tags, tagged_user_ids: [], media: [])
  end
end
