# frozen_string_literal: true

module Employees
  class EmployeesIndexComponent < ApplicationViewComponent
    include Pagy::Frontend

    attr_reader :employees, :pagy

    def initialize(employees:, pagy:)
      super()
      @employees = employees
      @pagy = pagy
    end
  end
end
