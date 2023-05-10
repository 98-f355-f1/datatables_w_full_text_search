# frozen_string_literal: true

class PagyComponent < ApplicationViewComponent
  include Pagy::Frontend

  attr_reader :pagy

  def initialize(pagy:)
    super()
    @pagy = pagy
  end
end
