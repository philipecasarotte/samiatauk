module ApplicationHelper
  def meta_tag
    unless @metatag.blank?
      unless @metatag.keywords.blank?
        @keywords = @metatag.keywords
      end
      unless @metatag.description.blank?
        @description = @metatag.description
      end
      unless @metatag.title.blank?
        @title = @metatag.title
      end
    end
  end
end