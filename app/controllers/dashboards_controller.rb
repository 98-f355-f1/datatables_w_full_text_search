# frozen_string_literal: true

class DashboardsController < ApplicationController
  def revenue
    # return unless turbo_frame_request?

    respond_to do |format|
      format.html { render partial: "dashboards/revenue_tab", locals: { data: Sale.total } }
    end
  end

  def orders
    # return unless turbo_frame_request?

    respond_to do |format|
      format.html { render partial: "dashboards/orders_tab", locals: { data: Sale.count } }
    end
  end
end
