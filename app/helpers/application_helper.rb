module ApplicationHelper

  def validate_i18n
    "plugins/validate_" + I18n.locale
    rescue
      "plugins/validate_en"
  end

end