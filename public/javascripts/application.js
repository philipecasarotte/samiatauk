$(function(){
	// ajax
	$(".ajax").click(function(){
		$.get($(this).attr("href"), null, null, "script");
		return false;
	});
	// validate
	$(".validate").each(function(){
		$(this).validate();
	});
	$(".act_as_tree .first").click(function() {
		if ($(this).hasClass("first")) {
			$.get($(this).attr("href"), null, null, "script");
		}
		return false;
	});
});
