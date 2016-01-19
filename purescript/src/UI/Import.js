'use strict';

// module UI.Import

exports.createEl = function(tag) {
	return function(attr) {
		return function() {
			return jQuery('<' + tag + '/>', attr);
		}
	}
}

exports.window = function() {
	return jQuery(window);
}

exports.document = function() {
	return jQuery(document);
}

exports.offset = function(ob) {
	return function() {
		return ob.offset();
	}
}

exports.scrollTop = function(ob) {
	return function() {
		return ob.scrollTop();
	}
}

exports.outerHeight = function(includeMargin) {
	return function(ob) {
		return function() {
			return ob.outerHeight(includeMargin);
		}
	}
}
