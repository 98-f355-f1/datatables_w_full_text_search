# frozen_string_literal: true

module Employees
  class EmployeeTableRowFormComponentPreview < ViewComponent::Preview
    def with_new_form
      render EmployeeTableRowFormComponent.new(employee: Employee.new)
    end

    def with_edit_form
      render EmployeeTableRowFormComponent.new(employee: Employee.first)
    end
  end
end
