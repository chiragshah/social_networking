class ProfileSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :first_name, :last_name, :description, :user_image, :is_public

  def user_image
    if object.image.attached?
      rails_representation_url(object.image)
    else
      nil
    end
  end
end
