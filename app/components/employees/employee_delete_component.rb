# frozen_string_literal: true

module Employees
  class EmployeeDeleteComponent < ApplicationViewComponent
    attr_reader :employee

    def initialize(employee:)
      super()
      @employee = employee
    end

    def render?
      !employee.new_record?
    end
  end
end
