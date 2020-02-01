module WebkitComponents
  class UsersController < ApplicationController
    def index
      render_serialized latest_users, WebkitComponents::UserSerializer
    end

    private

    def latest_users
      User.includes(:user_profile)
          .where.not(id: Discourse.system_user.id)
          .order(last_posted_at: :desc)
          .limit(params.fetch(:limit, 50))
    end
  end
end
