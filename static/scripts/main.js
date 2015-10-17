$.fn.goTopButton = function(options) {

	var body = $('html, body');
	var doc = $(document);
	var goPageTop = this;

	var settings = $.extend({
		hideClass : 'go-page-top--hide'
	}, options);

	this.on('click', function(e) {
		e.preventDefault();
		body.animate({scrollTop: 0});
	});

	function update() {
		var windowHeight = $(window).height();
		if (body.scrollTop() >= windowHeight / 2) {
			goPageTop.removeClass(settings.hideClass);
		} else {
			goPageTop.addClass(settings.hideClass);
		}
	}

	doc.on('scroll', update);
	update();
}

$(document).ready(function() {

	var doc = $(document);
	var body = $('html, body');

	var fontSize = parseInt($('body').css('font-size'));

	// Smooth scrolling code

	$('#main-nav > ul > li > a').each(function() {
		var id = $(this).attr('href');
		console.log(id);
		var offset = $(id).offset().top - 2*fontSize;

		$(this).on('click', function(e) {
			e.preventDefault();
			body.animate({scrollTop: offset});
		});
	});

	$('#go-page-top').goTopButton();

	// Fixed navbar code

});
