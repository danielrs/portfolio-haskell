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

exports.height = function(ob) {
	return function() {
		return ob.height();
	}
}

exports.outerHeight = function(includeMargin) {
	return function(ob) {
		return function() {
			return ob.outerHeight(includeMargin);
		}
	}
}

exports.getAttr = function(attr) {
	return function(ob) {
		return function() {
			return ob.attr(attr);
		}
	}
}

exports.animate = function(prop) {
	return function(speed) {
		return function(ob) {
			return function() {
				return ob.animate(prop, speed);
			}
		}
	}
}

exports.animateStop = function(ob) {
	return function() {
		return ob.stop();
	}
}

exports.listToArray = function(ob) {
	return function() {
		var arr = [];
		ob.each(function() {
			arr.push($(this).text());
		});
		return arr;
	}
}
