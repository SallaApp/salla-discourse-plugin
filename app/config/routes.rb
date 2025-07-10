# frozen_string_literal: true

Discourse::Application.routes.append do
  get "/t/:id/increment_count" => "salla_serializers/topics#increment_count"
  post "/t/:id/feature" => "salla_serializers/topics#feature"
  post "/t/:id/unfeature" => "salla_serializers/topics#unfeature"
end
