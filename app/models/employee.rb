# frozen_string_literal: true

# https://viblo.asia/p/rails-full-text-search-with-sqlite-OeVKBvvEKkW
# https://www.sqlite.org/fts3.html
# https://www.sqlite.org/fts5.html
# https://www.sqlitetutorial.net/sqlite-full-text-search/
# https://zarko-gajic.iz.hr/sqlite-referential-integrity-with-full-text-search-virtual-tables-used-in-a-delphi-application/
# https://www.speich.net/articles/en/2020/07/03/sqlite-fts4-standard-vs-enhanced-query-syntax/
class Employee < ApplicationRecord
  include Sqlite3Indexer
  include Sqlite3SafeMethods

  belongs_to :company

  # reset the cache when the model changes (you may omit the callbacks if your DB is static)
  after_create  { self.class.clear_cache }
  after_destroy { self.class.clear_cache }

  class << self
    def build_search(options = {})
      query = options.fetch(:query, nil)

      return all unless query.present?

      match = ActiveModel::Type::Boolean.new.cast(options[:match])

      return search_by_match(query) if match

      search_by_like(query)
    end

    def async_count
      async_count_by_sql("SELECT COUNT(*) FROM #{table_name}").value
    end

    def cache
      @cache ||= {}
    end

    def clear_cache
      cache.clear
    end

    attr_accessor :cache_key
  end

  validates :name, presence: true

  def fts_employee
    @fts_employees ||= {}.compare_by_identity
    @fts_employee_id ||= {}.compare_by_identity

    @fts_employee_id[self] ||= id
    @fts_employees[self] ||= FtsEmployee.find(@fts_employee_id[self])
  end
end

# == Schema Information
#
# Table name: employees
#
#  id         :integer          not null, primary key
#  name       :string
#  position   :string
#  office     :string
#  age        :integer
#  start_date :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
