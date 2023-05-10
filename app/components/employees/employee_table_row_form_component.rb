# frozen_string_literal: true

module Employees
  class EmployeeTableRowFormComponent < ApplicationViewComponent
    attr_reader :employee

    def initialize(employee:)
      super()
      @employee = employee
    end
  end
end
