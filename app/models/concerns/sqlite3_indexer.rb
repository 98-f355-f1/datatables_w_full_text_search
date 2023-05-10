# frozen_string_literal: true

module Sqlite3Indexer
  extend ActiveSupport::Concern

  included do # rubocop:disable Metrics/BlockLength
    instance_eval do
      target_search_class = Object.const_get("Fts#{name}")
      table_name          = target_search_class.name.underscore.to_sym
      foreign_key         = target_search_class.primary_key
      search_attributes   = target_search_class.attribute_names

      has_one(table_name, foreign_key:, dependent: :destroy)

      target_search_class.class_eval do
        define_method :id do
          quoted_name = target_search_class.connection.quote(name)
          sql = "SELECT fts_employees.rowid FROM fts_employees WHERE fts_employees.rowid = (SELECT employees.id FROM employees WHERE employees.name = #{quoted_name})"
          object = ActiveRecord::Base.connection.execute(sql)
          object[0].fetch("rowid")
        end

        define_method :rowid do
          id
        end
      end

      target_search_class.instance_eval do
        def search_attributes
          attribute_names
        end
      end

      begin
        search_on_fields(target_search_class, search_attributes.dup.insert(-2, foreign_key))
      rescue IndexError => _e # temporary fix for ViewComponent Tests
      end
    end

    def search_attributes
      self.class.search_attributes || []
    end

    # ghost method for model
    def content; end

    scope :search_by_like, lambda { |query|
      joins(:fts_employee).where("fts_employees.name LIKE ?", "%#{sanitize_sql_like(query)}%")
                          .or(
                            joins(:fts_employee).where("fts_employees.office LIKE ?", "%#{sanitize_sql_like(query)}%")
                          )
                          .or(
                            joins(:fts_employee).where("fts_employees.age LIKE ?", "%#{sanitize_sql_like(query)}%")
                          )
                          .or(
                            joins(:fts_employee).where("fts_employees.position LIKE ?", "%#{sanitize_sql_like(query)}%")
                          )
    }

    scope :search_by_match, ->(query) { joins(:fts_employee).where("fts_employees MATCH ?", query) }
  end

  class_methods do
    attr_reader :search_attributes

    def search_on_fields(model, fields)
      @table = model
      @search_attributes = fields
    end

    def build_indexes
      values = all.map { |instance| build_index(instance) }

      sql = <<~SQL.strip
        INSERT INTO #{@table.table_name}(#{search_attributes.join(', ')})
        VALUES #{values.join(',')}
      SQL

      connection.execute(sql)
    end

    def build_index(instance)
      names = search_attributes[0..-2].map do |column|
        column = "id" if column.end_with?("id")
        connection.quote(instance.public_send(column))
      end

      (names.join(", ").concat(", ") + content(names)).insert(0, "(").insert(-1, ")")
    end

    def content(names)
      names[0..-2].join(" ").gsub!(/'/, "").insert(0, "'").insert(-1, "'")
    end
  end
end
