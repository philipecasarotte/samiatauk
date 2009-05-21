module ApplicationHelper

	def validate_i18n
		"plugins/validate_" + I18n.locale
		rescue
			"plugins/validate_en"
	end

	def javascript(*files)
		content_for(:head) { javascript_include_tag(*files) }
	end

	def stylesheet(*files)
		content_for(:head) { stylesheet_link_tag(*files) }
	end
end