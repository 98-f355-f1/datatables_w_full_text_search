# frozen_string_literal: true

# https://divtable.com/table-style
class DataTableComponent < ApplicationViewComponent
  def initialize(model_data:, width:)
    super()
    @model_data = model_data
    @table_width = width
  end

  private

  attr_reader :model_data, :table_width
end
