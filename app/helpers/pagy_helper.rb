# frozen_string_literal: true

module PagyHelper
  def pagy_custom(collection, vars = {})
    pagy = Pagy.new(pagy_get_vars(collection, vars))
    [pagy, collection.offset(pagy.offset).limit(pagy.items)]
  end

  # override the pagy_get_vars method so it will call your cache_count method
  def pagy_get_vars(collection, vars)
    vars[:count] ||= cache_count(collection)
    vars[:page]  ||= params[vars[:page_param] || Pagy::DEFAULT[:page_param]]
    vars
  end

  # add Rails.cache wrapper around the count call
  def cache_count(collection)
    model = collection.model
    model.cache_key = "pagy-#{model.name}:#{collection.to_sql}"
    model.cache[model.cache_key] ||= model.async_count
  end
end
