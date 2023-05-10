# frozen_string_literal: true

module Employees
  class EmployeeTableRowComponent < TableRowComponent
    with_collection_parameter :employee

    attr_reader :employee

    def initialize(employee:)
      super()
      @employee = employee
    end

    private

    %i[name position office age start_date].each do |attr|
      define_method "#{attr}_in_search?" do |query = view_context.params[:query]|
        query&.include?(attr.to_s)
      end
    end
  end
end
