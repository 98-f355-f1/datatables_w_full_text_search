class AddCompanyRefToEmployees < ActiveRecord::Migration[7.1]
  def change
    add_reference :employees, :company, foreign_key: true
  end
end
