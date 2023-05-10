# frozen_string_literal: true

class SalesController < ApplicationController
  def index
    @revenue = Sale.total || 0
  end
end
