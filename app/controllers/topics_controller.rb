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

    def feature
      topic = Topic.find_by(id: params[:id])
      guardian.ensure_can_moderate!(topic)
      topic.archetype = Archetype::FEATURED
      topic.save!
      render json: { success: true, archetype: topic.archetype }
    rescue => e
      render json: { success: false, error: e.message }, status: 422
    end

    def unfeature
      topic = Topic.find_by(id: params[:id])
      guardian.ensure_can_moderate!(topic)
      topic.archetype = Archetype.default
      topic.save!
      render json: { success: true, archetype: topic.archetype }
    rescue => e
      render json: { success: false, error: e.message }, status: 422
    end
  end
end
