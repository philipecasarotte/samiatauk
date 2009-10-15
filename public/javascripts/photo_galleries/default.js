$(document).ready(function() {
	//Drop Down
	$("#drop_down").hoverIntent(down,up);
	
	$("#images a").lightBox({txtImage: "Fotos", txtOf: "de", fixedNavigation:false});
});

function down(){
	$("#drop_down ul").animate({height: 'toggle', opacity: 'toggle' },200);
} 

function up(){
	$("#drop_down ul").animate({height: 'toggle', opacity: 'toggle' },300);
}

