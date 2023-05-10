# frozen_string_literal: true

class Sale < ApplicationRecord
  after_commit lambda {
    broadcast_update_to "revenue", partial: "metrics/revenue", locals: { data: Sale.total }, target: "revenue"
  }

  after_commit lambda {
    broadcast_update_to "orders", partial: "metrics/data", locals: { data: Sale.count }, target: "orders"
  }

  def self.total
    pluck(:amount).sum
  end
end
