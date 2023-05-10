# frozen_string_literal: true

require "test_helper"

class EmployeeTableRowComponentTest < ViewComponent::TestCase
  def test_component_renders_employee_table_row
    employee_first = employees(:first)
    employee_secon = employees(:second)
    employees = [employee_first, employee_secon]

    render_inline(Employees::EmployeeTableRowComponent.with_collection(employees))

    assert_selector("div[data-label='name']", text: employee_first.name)
    assert_selector("div[data-label='position']", text: employee_secon.position)
  end
end
