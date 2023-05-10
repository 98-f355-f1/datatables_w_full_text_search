# frozen_string_literal: true

class DataTableHeaderComponent < ApplicationViewComponent
  include SortableColumnsHelper

  class << self
    attr_reader :table_header_columns

    def with_table_header_columns(*args)
      except = args.last[:except] if args.last.is_a? Hash

      args = extract_attribute_names - except.map(&:to_s) if except.present?

      args = extract_attribute_names if args.empty?

      @table_header_columns = args.each_with_object({}) do |column, hash|
        hash[column] = column.to_s.humanize
      end
    end

    private

    def extract_attribute_names
      class_name = name
      offset = class_name.rindex(superclass.name)
      base_table_name = class_name.slice(0, offset)
      base_table_name.constantize.attribute_names(&:to_sym)
    end
  end

  attr_reader :css_classes, :turbo_action, :crud_actions

  # delegate :sort_link_to, to: :helpers # this is if the helper method is in ApplicationHelper
  with_table_header_columns :name, :position, :office, :age, :start_date
  # with_table_header_columns except: %i[id created_at updated_at]

  def initialize(options = {})
    super()

    @css_classes  = options.fetch(:css_classes, "")
    @turbo_action = options.fetch(:turbo_action, "advance")
    @crud_actions = options.delete(:crud_actions)
  end

  def table_header_columns
    self.class.table_header_columns
  end
end
