# frozen_string_literal: true

class CreateFtsEmployeeTable < ActiveRecord::Migration[7.0]
  def up
    execute("CREATE VIRTUAL TABLE fts_employees USING fts4(name, position, office, age, start_date, content)")
  end

  def down
    execute("DROP TABLE IF EXISTS fts_employees")
  end
end
