module WebkitComponents
  class BaseController < ApplicationController
    def index
      render_serialized records_to_serialize, serializer
    end

    private

    def records_to_serialize
      relevant_records.limit(params.fetch(:per, 50)).offset(params.fetch(:from, 0))
    end

    def relevant_records
      raise NotImplementedError.new
    end

    def serializer
      "WebkitComponents::#{params.fetch(:serializer, controller_name).humanize.singularize}Serializer".constantize
    end
  end
end
