class PostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :body, :urls, :all_tags

  def urls
    if object.media.attached?
      object.media.map{ |m| {id: m.id, type: m.content_type.include?("image") ? "image" : "video", url: rails_representation_url(m)} }
    else
      []
    end
  end
end
