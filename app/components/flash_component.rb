# frozen_string_literal: true

class FlashComponent < ViewComponent::Base
  attr_reader :flash_notice

  def initialize(flash_notice:)
    super()
    @flash_notice = flash_notice
  end

  def render?
    flash_notice.present?
  end
end
