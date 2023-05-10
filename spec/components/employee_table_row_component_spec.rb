# frozen_string_literal: true

require "rails_helper"

# https://www.bearer.com/blog/snapshot-testing-viewcomponents-with-rspec
RSpec.describe Employees::EmployeeTableRowComponent, type: :component do
  describe "table row" do
    context "with employee" do
      let(:employee) { Employee.first }

      it "renders a table row with employee data", :snapshot do
        render_inline(described_class.new(employee:))

        expect(page).to have_css "div[data-label='name']", text: employee.name
        expect(page).to have_css "div[data-label='start date']", text: employee.start_date
      end
    end
  end
end
