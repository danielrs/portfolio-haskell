// Calls 'before' when elemId is not yet out-of viewport from the top
// otherwise calls 'after'
(function($) {
	var created = 0;
	var index = {}; // holds id -> scope pairs

	$.fn.scrollCall = function(before, after) {
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
				if ($doc.scrollTop() < $(i).offset().top) {
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

	var $doc = $(document);
	var $body = $('html, body');
	var $goPageTop = $('#go-page-top');
	var fontSize = parseInt($('body').css('font-size'));

	$('#main-nav > ul > li > a').each(function() {
		var id = $(this).attr('href');
		$(this).on('click', function(e) {
			history.replaceState(null, '', id);
			var offset = $(id).offset().top - 2*fontSize - $('#main-nav ul').height();
			e.preventDefault();
			$body.stop();
			$body.animate({scrollTop: offset});
		});
	});
	if (window.location.hash) {
		$('#main-nav > ul > li > a[href="' + window.location.hash + '"]').trigger('click');
	}

	// Scroll events
	$('#main-nav').scrollCall(
		function() {
			console.log('before');
			// Nav bar
			var $dummy = $('#main-nav--dummy');
			this.removeClass('main-nav--fixed');
			this.css('height', 'auto');
			$dummy.remove();
			// Go top
			$goPageTop.addClass('go-page-top--hide');
		},
		function() {
			console.log('after');
			// Nav bar
			var $dummy = $('#main-nav--dummy');
			if ($dummy.length <= 0) $dummy = $('<div>', { id : 'main-nav--dummy' });
			$dummy.css('height', $('#main-nav').outerHeight(true));
			this.addClass('main-nav--fixed');
			this.after($dummy);
			// Go top
			$goPageTop.removeClass('go-page-top--hide');
		}
	);
	// When #go-page-top is clicked go back top
	$goPageTop.click(function(e) {
		e.preventDefault();
		history.replaceState(null, '', window.location.origin);
		$body.animate({ scrollTop: 0});
	});

	// Message notification
	var $message = $('#message');
	$message.addClass('message--fixed');
	$message.delay(4000).fadeOut();
});
