# frozen_string_literal: true

module SallaSerializers
    class PublicUsersController < ::ApplicationController
        def index
            page = params[:page].to_i > 0 ? params[:page].to_i : 1
            per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 20
            users = User.all
            total_count = users.count
            paginated = users.select(:id, :username, :updated_at).offset((page - 1) * per_page).limit(per_page)
            render json: {
              users_list: paginated.map { |u| u.as_json(only: [:id, :username, :updated_at]) },
              meta: {
                page: page,
                per_page: per_page,
                total_count: total_count,
                total_pages: (total_count / per_page.to_f).ceil
              }
            }
        rescue => e
            Rails.logger.error("Error: #{e.message}")
            Rails.logger.error("Backtrace: #{e.backtrace.join("\n")}")
            render json: { error: "An unexpected error occurred. Please try again later." }, status: 500
        end
    end
end