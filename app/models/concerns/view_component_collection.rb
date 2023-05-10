# frozen_string_literal: true

module ViewComponent
  class Collection
    def to_partial_path
      puts [@component, @collection, @options]
      collection = @collection.to_s
      collection.gsub("::", "/").underscore
    end
  end
end
