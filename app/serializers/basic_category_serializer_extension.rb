# frozen_string_literal: true

BasicCategorySerializer.class_eval do
  attributes :only_admin_can_post,
            :emoji

  def emoji
    "https://community.salla.com/forum/#{object.id}.png"
  end

  def only_admin_can_post
    object.groups.exists?(name: "admins")
  end
end

CategoryDetailedSerializer.class_eval do
  attributes :custom_frontend_fields

  def custom_frontend_fields
    object._custom_fields.map { |f| [f.name, f.value] }.to_h
  end
end