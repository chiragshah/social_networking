class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :authenticate, only: [:sign_up, :share, :search]

  def sign_up
    resource = User.new(permitted_params)
    if resource.save
      render json: resource
    else
      full_resource_errors(resource)
    end
  end

  def share
    if user = User.find(params[:id])
      if user.is_public
        render json: user, serializer: ProfileSerializer
      else
        render status: :unprocessable_entity, json: { errors: "User profile is private" }
      end
    else
      render status: :not_found, json: { errors: "User not found" }
    end
  end

  def search
    if params[:term].present?
      term = "%#{params[:term]}%"
      users = User.where("LOWER(email) LIKE :term OR LOWER(first_name) LIKE :term OR LOWER(last_name) LIKE :term OR LOWER(username) LIKE :term", term: term)
      users = ActiveModel::Serializer::CollectionSerializer.new(users, serializer: ProfileSerializer)

      posts = Post.where("LOWER(body) LIKE :term", term: term)
      posts = ActiveModel::Serializer::CollectionSerializer.new(posts)
      render json: {
        users: users,
        posts: posts
      }
    else
      render json: {}
    end
  end

  def show
    if user = User.find_by(id: params[:id])
      render json: user
    else
      render status: :not_found, json: { errors: "User not found" }
    end
  end

  def update
    resource = User.find_by(id: params[:id])
    render status: :not_found, json: { errors: "User not found" } unless resource
    if resource != @current_user
      render status: :unprocessable_entity, json: { errors: "You can't update user" }
    else
      if resource.update(permitted_params)
        render json: resource
      else
        full_resource_errors(resource)
      end
    end
  end

  def follow
    if resource = User.find(params[:id])
      @current_user.followed_users.build(followee_id: resource.id)
      if @current_user.save
        render json: @current_user
      else
        full_resource_errors(@current_user)
      end
    else
      render status: :not_found, json: { errors: "User not found" }
    end
  end

  def unfollow
    if resource = User.find(params[:id])
      @current_user.followed_users.find_by(followee_id: resource.id).destroy
      render json: @current_user
    else
      render status: :not_found, json: { errors: "User not found" }
    end
  end

  def followers
    render json: @current_user.followers
  end

  def followees
    render json: @current_user.followees
  end

  private

  def permitted_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :description, :image, :is_public)
  end
end
