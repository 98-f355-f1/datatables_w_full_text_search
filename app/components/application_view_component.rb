# frozen_string_literal: true

class ApplicationViewComponent < ViewComponent::Base
  include Turbo::FramesHelper
  include ParamsExtractionHelper
  include FlashHelper
end
