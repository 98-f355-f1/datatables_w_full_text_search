# frozen_string_literal: true

require "test_helper"

module Employees
  class EmployeeTableRowFormComponentTest < ViewComponent::TestCase
    def test_render_preview
      render_preview(:with_new_form)

      assert_text("Creating new employee")
    end
  end
end
