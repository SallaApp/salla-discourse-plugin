# frozen_string_literal: true

module SallaSerializers
  class TopicsController < ::ApplicationController
    def increment_count
      TopicViewItem.add(
        params[:id],
        request.remote_ip,
        current_user ? current_user.id : nil
      )
      head :ok
    end
  end
end
