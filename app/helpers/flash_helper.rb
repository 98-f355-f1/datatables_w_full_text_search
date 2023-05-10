# frozen_string_literal: true

module FlashHelper
  def with_flash_content(flash)
    @flash_notice = flash
    with_content(@flash_notice.to_s)
  end

  def inline_error_for(field, form_obj)
    return unless form_obj.errors[field].any?

    html = []
    html << form_obj.errors[field].map do |msg|
      error_msg = "#{field.capitalize} #{msg}"
      tag.div(error_msg, class: "field-with-errors text-red-600 font-semibold text-xs m-0 p-0 mb-2 flex justify-end")
    end

    html.join.html_safe
  end

  private

  attr_reader :flash_notice
end
