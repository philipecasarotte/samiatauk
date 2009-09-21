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

  def data_table(options={})
   options.reverse_merge! "sPaginationType" => "full_numbers",
                          "bStateSave" => true,
                          "bInfo" => false,
                          "iDisplayLength" => "100",
                          "aaSorting" => [[ 0, "asc"]],
                          "oLanguage" => {"sUrl" => "/javascripts/plugins/data_tables_#{I18n.locale}.js"}
   content_for(:head) do
     javascript_tag do
       "$(function(){oTable = $('#table').dataTable(#{options.to_json}).css('width', 'auto');});"
     end
   end
  end

end