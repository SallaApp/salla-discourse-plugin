# frozen_string_literal: true

module SallaSerializers
    class PublicUsersController < ::ApplicationController
        def index
            page = params[:page].to_i > 0 ? params[:page].to_i : 1
            per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 20
            users = User.all
            paginated = users.select(:id, :username, :name).offset((page - 1) * per_page).limit(per_page)
            render json: {
              users_list: paginated.map { |u| u.as_json(only: [:id, :username, :name]) },
              meta: {
                page: page,
                per_page: per_page,
                total_count: users.count,
                total_pages: (users.count / per_page.to_f).ceil
              }
            }
        rescue => e
            render json: { error: e.message, backtrace: e.backtrace }, status: 500
        end
    end
end