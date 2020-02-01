module WebkitComponents
  class TopicsController < ApplicationController
    def index
      render_serialized relevant_topics, serializer
    end

    private

    def relevant_topics
      Topic.includes(user: :user_profile)
           .joins(:tags)
           .yield_self { |r| relevant_tags ? r.where("tags.name": relevant_tags) : r }
    end

    def relevant_tags
      params[:tags].to_s.split(',').presence
    end

    def serializer
      "WebkitComponents::#{params[:serializer].to_s.humanize}Serializer".constantize
    rescue NameError
      WebkitComponents::TopicSerializer
    end
  end
end
