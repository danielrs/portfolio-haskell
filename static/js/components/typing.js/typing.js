(function($) {

	// Checks if object given is a function. Taken from underscorejs source code
	function isFunction(obj) {
		return !!(obj && obj.constructor && obj.call && obj.apply);
	}

	// Drops the given number of characters from the end of the string
	function dropTail (string, n) {
		return string.substr(0, string.length - n);
	}

	// Returns a new string, 1 edit distance from current and closer to target
	function typeTo(current, target) {
		if (current !== target) {
			var subTarget = target.substr(0, current.length);
			if (current !== subTarget) return dropTail(current, 1);
			else return current + target.charAt(current.length);
		}
		return current;
	}

	$.fn.type = function(targetStr, options) {

		// SETTINGS
		var settings = {
			caretChar: '_',
			caretClass: 'typejs__caret',
			ignoreContent: false,
			typeDelay: 50,
			onType: null,
			onBackspace: null,
			onFinish: null
		};
		$.extend(settings, options);

		return this.each(function() {

			// Sets up element
			var this_ = $(this);
			var text = this_.text();
			if (this_.children('.typejs__content').length > 0)
				text = this_.children('.typejs__content').text();

			var $content = $('<span>', { class: 'typejs__content', text: text});
			var $caret = $('<span>', { class: settings.caretClass, text: settings.caretChar });

			this_.empty();
			this_.append($content);
			this_.append($caret);

			function typeStep(current, target) {
				if (current !== target) {
					var newStr = typeTo(current, target);
					// Step callback
					if (newStr.length > current.length && isFunction(settings.onType)) {
						settings.onType.call(this_);
					} else if (newStr.length < current.length && isFunction(settings.onBackspace)) {
						settings.onBackspace.call(this_)
					}
					// Update content
					$content.text(newStr);
					// Next step
					setTimeout(typeStep, settings.typeDelay, newStr, targetStr);
				} else if (isFunction(settings.onFinish)) {
					// Finished callback
					settings.onFinish.call(this_);
				}
			}

			setTimeout(typeStep, settings.typeDelay, $content.text(), targetStr);

		}); // each
	}; // function type
})(jQuery);
