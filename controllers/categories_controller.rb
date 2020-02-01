module WebkitComponents
  class CategoriesController < ApplicationController
    def index
      render_serialized relevant_categories, CategorySerializer
    end

    private

    def relevant_categories
      Category.where.not(name: ENV['WEBKIT_EXCLUDED_CATEGORIES'].to_s.split(','))
              .where.not(description: nil)
              .joins(:latest_post)
              .order("posts.created_at": :desc)
    end
  end
end
