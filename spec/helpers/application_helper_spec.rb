require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationHelper, :type => :helper do
  
  describe "validate_i18n" do

    it "should not call javascript validation language file for English" do
      I18n.locale = "en"
      helper.validate_i18n.should == "plugins/validate_en"
    end

    it "should get the javascript validation language file for Brazilian Portuguese" do
      I18n.locale = "pt-BR"
      helper.validate_i18n.should == "plugins/validate_pt-BR"
    end

  end
  
  
end