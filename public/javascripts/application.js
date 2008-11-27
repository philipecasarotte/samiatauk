// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
	$(".ajax").click(function(){
		$.get($(this).attr("href"), null, null, "script");
		return false;
	});
});