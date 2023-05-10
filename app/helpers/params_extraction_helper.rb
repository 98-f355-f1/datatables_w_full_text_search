# frozen_string_literal: true

module ParamsExtractionHelper
  def extract_search_and_or_sort_params(params)
    { query: params[:query], match: params[:match], count: params[:count], page: params[:page] }
  end
end
