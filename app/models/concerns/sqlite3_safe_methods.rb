# frozen_string_literal: true

module Sqlite3SafeMethods
  extend ActiveSupport::Concern

  def safe_save # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    return false unless save

    content =
      Employee.where(id:).pluck(:name, :position, :office, :age, :start_date).flatten.join(" ")

    quoted_content  = self.class.connection.quote(content)
    quoted_id       = self.class.connection.quote(id)

    sql = <<-SQL.strip
    INSERT INTO fts_employees (rowid, name, position, office, age, start_date)
    SELECT employees.id, employees.name, employees.position, employees.office, employees.age, employees.start_date
    FROM employees
    WHERE employees.id = #{quoted_id}
    SQL

    self.class.connection.execute(sql)

    sql = <<-SQL.strip
    UPDATE fts_employees
    SET content = #{quoted_content}
    WHERE fts_employees.rowid = #{quoted_id}
    SQL

    self.class.connection.execute(sql) || false
  end

  def safe_update(attributes = {}) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    return false unless update(attributes)

    search_attributes.delete_at(5) if search_attributes.include? "rowid"
    new_content = search_attributes.map do |attr|
      public_send attr
    end.join(" ").strip

    quoted_content  = self.class.connection.quote(new_content)
    quoted_id       = self.class.connection.quote(id)
    klass_name      = Object.const_get("Fts#{self.class}")
    fts_classname   = klass_name.table_name
    this_classname  = self.class.table_name

    class_with_attributes = attribute_names.intersection(klass_name.attribute_names)
    selected_attributes   = class_with_attributes.map { |attr| "#{this_classname}.#{attr}" }.join(", ")

    sql = <<-SQL.strip
    UPDATE #{fts_classname}
    SET (#{class_with_attributes.join(', ')}) = (
      SELECT #{selected_attributes}
      FROM #{this_classname}
      WHERE #{this_classname}.id = #{quoted_id})
    WHERE #{fts_classname}.rowid = #{quoted_id}
    SQL

    self.class.connection.execute(sql)

    sql =
      "UPDATE #{fts_classname} SET content = #{quoted_content} WHERE #{fts_classname}.rowid = #{quoted_id}"

    self.class.connection.execute(sql) || false
  end

  def safe_destroy
    FtsEmployee.delete(fts_employee.id) # should be extracted somehow
    destroy
  end
end
