module WebkitComponents
  class TopicsController < BaseController
    private

    def relevant_records
      Topic.includes(user: :user_profile)
           .joins(:tags)
           .yield_self { |r| relevant_tags ? r.where("tags.name": relevant_tags) : r }
    end

    def relevant_tags
      params[:tags].to_s.split(',').presence
    end
  end
end
