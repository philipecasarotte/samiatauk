$(function (){
	//Admin Menu
	$("#menu").superfish({
		hoverClass	: "sfHover",
		currentClass: "overideThisToUse",
		delay		: 800,
		animation	: {opacity:"show"},
		speed		: "normal"
	});
	// validate
	$(".validate").each(function(){
		$(this).validate();
	});
});