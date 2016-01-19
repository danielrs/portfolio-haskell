'use strict';

// module Control.Monad.Eff.JQuery.Typing

exports.typing = function(settings) {
	return function(ob) {
		return function() {
			ob.typing(settings);
		}
	}
}
