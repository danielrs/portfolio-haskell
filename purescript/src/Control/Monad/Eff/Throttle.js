'use strict';

// module Control.Monad.Eff.Throttle

exports.debounceImpl = function(ms, fn) {
	var timeout = undefined;
	return function() {
		clearTimeout(timeout);
		timeout = setTimeout(function() {
			fn();
		}, ms);
	}
}

exports.debounceMaybeImpl = function(nothing, just, ms, fn) {
	var last = Date.now();
	return function() {
		const now = Date.now();
		if (now >= last + ms) {
			last = now;
			return just(fn);
		}
		else {
			last = now;
			return nothing;
		}
	}
}

exports.throttleImpl = function(ms, fn) {
	var last = Date.now(),
			timeout = undefined;
	return function() {
		const now = Date.now();
		if (now < last + ms) {
			clearTimeout(timeout);
			timeout = setTimeout(function() {
				last = now;
				fn(arguments);
			}, ms);
		}
		else {
			last = now;
			fn(arguments);
		}
	}
}

exports.throttleMaybeImpl = function(nothing, just, ms, fn) {
	var	last = Date.now();
	return function() {
		const now = Date.now();
		if (now >= last + ms) {
			last = now;
			return just(fn);
		}
		else {
			return nothing;
		}
	}
}
