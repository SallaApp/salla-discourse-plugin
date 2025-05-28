# frozen_string_literal: true

# name: salla_serializers
# about: Add Salla serializers
# version: 1.0
# authors: Ahsan Afzal

enabled_site_setting :salla_serializers_enabled

after_initialize do
  %w[
    basic_category_serializer_extension
    post_serializer_extension
    suggested_topic_serializer_extension
    topic_list_item_serializer_extension
  ].each do |file|
    require_relative "app/serializers/#{file}"
  end

  register_asset "app/views/user_notifications/digest.html.erb", :email

  require_relative "app/controllers/topics_controller.rb"
  load File.expand_path("app/config/routes.rb", __dir__)

  require_relative "lib/salla_serializers/controller_extensions"
  ::ApplicationController.class_eval do
    include ::SallaSerializers::ControllerExtensions
  end

  require_relative "lib/salla_serializers/tags_controller_patch"
  ::TagsController.prepend SallaSerializers::TagsControllerPatch

  require_relative "lib/salla_serializers/middleware_patch"
  ContentSecurityPolicy::Middleware.prepend SallaSerializers::MiddlewarePatch

  require_relative "lib/salla_serializers/email_interceptor"
  ActionMailer::Base.register_interceptor(SallaSerializers::EmailInterceptor)

  require_relative "lib/salla_serializers/auth_cookie_patch"
  ::Auth::DefaultCurrentUserProvider.prepend SallaSerializers::AuthCookiePatch

  require_relative "lib/salla_serializers/application_controller_patch"
  ::ApplicationController.prepend SallaSerializers::ApplicationControllerPatch
end