$.fn.goTopButton = function(options) {
	var $body = $('html, body');
	var $doc = $(document);
	var goPageTop = this;

	var settings = $.extend({
		hideClass : 'go-page-top--hide',
		appearId : undefined,
		appearOffset : function() { $(window).height() / 2 }
	}, options);

	this.on('click', function(e) {
		e.preventDefault();
		$body.stop();
		$body.animate({scrollTop: 0});
	});

	function update() {
		var checkpoint = settings.appearOffset();
		if (settings.appearId !== undefined) checkpoint = $(settings.appearId).offset().top;
		if ($body.scrollTop() >= checkpoint) {
			goPageTop.removeClass(settings.hideClass);
		} else {
			goPageTop.addClass(settings.hideClass);
		}
	}

	$doc.on('scroll', update);
	update();

	return this; // for chaining jquery methods
};

// Calls 'before' when elemId is not yet out-of viewport from the top
// otherwise calls 'after'
(function($) {
	var created = 0;
	var index = {}; // holds id -> scope pairs

	$.fn.scrollCall = function(before, after) {
		var $body = $('html, body');
		var $doc = $(document);

		this.each(function() {
			var checkpointId = 'scrollcall-checkpoint-' + created;
			var $checkpoint = $('<div>', {
				id : checkpointId,
				class : 'scrollcall-checkpoint'
			});
			$(this).before($checkpoint);
			index['#' + checkpointId] = $(this);
			created++;
		});

		$doc.scroll(function() {
			$.each(index, function(i, scope) {
				if ($body.scrollTop() < $(i).offset().top) {
					if (!$(i).data('before-done')) before.call(scope);
					$(i).data('before-done', true);
					$(i).data('after-done', false);
				} else {
					if (!$(i).data('after-done')) after.call(scope);
					$(i).data('before-done', false);
					$(i).data('after-done', true);
				}
			});
		});
		$(window).resize(function() {
			$doc.trigger('scroll');
		});
		$doc.trigger('scroll');
	};

})(jQuery);

$(document).ready(function() {

	var doc = $(document);
	var body = $('html, body');
	var fontSize = parseInt($('body').css('font-size'));

	$('#main-nav > ul > li > a').each(function() {
		var id = $(this).attr('href');
		$(this).on('click', function(e) {
			var offset = $(id).offset().top - 2*fontSize - $('#main-nav ul').height();
			e.preventDefault();
			body.stop();
			body.animate({scrollTop: offset});
		});
	});

	$('#go-page-top').goTopButton({
		appearId : '#main-nav' // appear after #main-nav
	});

	// Fixed navbar code
	$('#main-nav').scrollCall(
		function() {
			console.log('before');
			var $dummy = $('#main-nav--dummy');
			this.removeClass('main-nav--fixed');
			this.css('height', 'auto');
			$dummy.remove();
		},
		function() {
			console.log('after');
			// Selects or creates dummy object
			var $dummy = $('#main-nav--dummy');
			if ($dummy.length <= 0) $dummy = $('<div>', { id : 'main-nav--dummy' });
			$dummy.css('height', $('#main-nav').outerHeight(true));
			this.addClass('main-nav--fixed');
			this.after($dummy);
		}
	);
});
