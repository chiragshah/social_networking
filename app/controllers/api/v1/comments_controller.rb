class Api::V1::CommentsController < Api::V1::BaseController
	before_action :set_post
	before_action :verify_commenter
	before_action :set_resource, only: [:update, :destroy]

  def index
    render json: @post.comments.parents
  end

  def create
    resource = @post.comments.new(permitted_params.merge(user_id: @current_user.id))
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

  def destroy
    if @resource.destroy
      render status: :ok
    else
      full_resource_errors(@resource)
    end
  end

  private

  def set_post
  	@post = Post.find(params[:post_id])
  end

  def verify_commenter
  	user = @post.user
  	unless user.followers.include?(@current_user)
  		render json: :unprocessable_entity, json: {errors: "You can't comment on this post"}
  	end
  end

  def set_resource
    @resource = @post.comments.find(params[:id])
  end

  def permitted_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
