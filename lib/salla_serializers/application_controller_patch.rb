# frozen_string_literal: true

module SallaSerializers
  module ApplicationControllerPatch
    def handle_unverified_request
      return # NOTE: API key is secret, having it invalidates the need for a CSRF token
      unless is_api? || is_user_api?
        super
        clear_current_user
        render plain: "[\"BAD CSRF\"]", status: 403
      end
    end
  end
end