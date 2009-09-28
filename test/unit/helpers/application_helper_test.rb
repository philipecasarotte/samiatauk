require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  
  context "On admin layout" do

    should "not call javascript validation language file for English" do
      I18n.locale = "en"
      assert_equal "plugins/validate_en", validate_i18n
    end

    should "get the javascript validation language file for Brazilian Portuguese" do
      I18n.locale = "pt-BR"
      assert_equal "plugins/validate_pt-BR", validate_i18n
    end

  end
end