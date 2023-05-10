# frozen_string_literal: true

module SortableColumnsHelper
  def sort_link_to(name, column, **options)
    direction = params[:sort] == column.to_s ? next_direction : "asc"

    link_to(name, sortable_url_builder(column, direction), **options)
  end

  def sort_column(model)
    column_names = model.column_names.reject { |meth| meth.end_with? "_at" }
    column_names.include?(params[:sort]) ? params[:sort] : column_names.first
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def next_direction
    params[:direction] == "asc" ? "desc" : "asc"
  end

  def sort_indicator
    direction = params[:direction] == "asc" ? "fa-arrow-up-a-z" : "fa-arrow-down-z-a"
    "sort fa-solid #{direction} fa-sm fa-fade"
  end

  def stringify(string)
    string&.humanize&.downcase
  end

  private

  def sortable_url_builder(column, direction)
    {
      controller: url_for(controller_name),
      action: "index"
    }.merge(sort: column, direction:, **extract_search_and_or_sort_params(params))
  end
end
