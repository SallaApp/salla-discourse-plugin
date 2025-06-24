# frozen_string_literal: true

BasicCategorySerializer.class_eval do
  attributes :only_admin_can_post,
            :emoji

  def emoji
    Discourse.base_url_no_prefix + object.uploaded_logo&.url.to_s
  end

  def only_admin_can_post
    object.groups.exists?(name: "admins")
  end
end