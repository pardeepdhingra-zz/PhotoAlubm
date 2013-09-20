class Picture < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  mount_uploader :avatar, AvatarUploader

  belongs_to :album

  #one convenient method to pass jq_upload the necessary information
  def to_jq_upload
    {
      "name" => read_attribute(:avatar),
	  "title" => title,
      "size" => avatar.size,
      "url" => avatar.url,
      "thumbnail_url" => avatar.thumb.url,
      "delete_url" =>  "/albums/#{album_id}/pictures/#{id}" ,#album_pictures_path(:album_id=>album_id,:id => id),
      "delete_type" => "DELETE"
    }
  end
end
