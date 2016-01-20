// Generated by psc-bundle 0.7.6.1
var PS = { };
(function(exports) {
  /* global exports */
  "use strict";

  // module Control.Monad.Eff

  exports.returnE = function (a) {
    return function () {
      return a;
    };
  };

  exports.bindE = function (a) {
    return function (f) {
      return function () {
        return f(a())();
      };
    };
  };
 
})(PS["Control.Monad.Eff"] = PS["Control.Monad.Eff"] || {});
(function(exports) {
  /* global exports */
  "use strict";

  //- Eq -------------------------------------------------------------------------

  exports.refEq = function (r1) {
    return function (r2) {
      return r1 === r2;
    };
  };
 
})(PS["Prelude"] = PS["Prelude"] || {});
(function(exports) {
  // Generated by psc version 0.7.6.1
  "use strict";
  var $foreign = PS["Prelude"];
  var Functor = function (map) {
      this.map = map;
  };
  var Apply = function (__superclass_Prelude$dotFunctor_0, apply) {
      this["__superclass_Prelude.Functor_0"] = __superclass_Prelude$dotFunctor_0;
      this.apply = apply;
  };
  var Applicative = function (__superclass_Prelude$dotApply_0, pure) {
      this["__superclass_Prelude.Apply_0"] = __superclass_Prelude$dotApply_0;
      this.pure = pure;
  };
  var Bind = function (__superclass_Prelude$dotApply_0, bind) {
      this["__superclass_Prelude.Apply_0"] = __superclass_Prelude$dotApply_0;
      this.bind = bind;
  };
  var Monad = function (__superclass_Prelude$dotApplicative_0, __superclass_Prelude$dotBind_1) {
      this["__superclass_Prelude.Applicative_0"] = __superclass_Prelude$dotApplicative_0;
      this["__superclass_Prelude.Bind_1"] = __superclass_Prelude$dotBind_1;
  };
  var Eq = function (eq) {
      this.eq = eq;
  };                                                                           
  var unit = {};      
  var pure = function (dict) {
      return dict.pure;
  };
  var $$return = function (__dict_Applicative_2) {
      return pure(__dict_Applicative_2);
  };
  var map = function (dict) {
      return dict.map;
  };
  var $less$dollar$greater = function (__dict_Functor_5) {
      return map(__dict_Functor_5);
  }; 
  var eqString = new Eq($foreign.refEq);
  var eq = function (dict) {
      return dict.eq;
  };
  var $eq$eq = function (__dict_Eq_7) {
      return eq(__dict_Eq_7);
  };
  var bind = function (dict) {
      return dict.bind;
  };
  var $greater$greater$eq = function (__dict_Bind_24) {
      return bind(__dict_Bind_24);
  }; 
  var apply = function (dict) {
      return dict.apply;
  };
  var $less$times$greater = function (__dict_Apply_25) {
      return apply(__dict_Apply_25);
  };
  var liftA1 = function (__dict_Applicative_26) {
      return function (f) {
          return function (a) {
              return $less$times$greater(__dict_Applicative_26["__superclass_Prelude.Apply_0"]())(pure(__dict_Applicative_26)(f))(a);
          };
      };
  };
  var ap = function (__dict_Monad_30) {
      return function (f) {
          return function (a) {
              return bind(__dict_Monad_30["__superclass_Prelude.Bind_1"]())(f)(function (_2) {
                  return bind(__dict_Monad_30["__superclass_Prelude.Bind_1"]())(a)(function (_1) {
                      return $$return(__dict_Monad_30["__superclass_Prelude.Applicative_0"]())(_2(_1));
                  });
              });
          };
      };
  };
  exports["Eq"] = Eq;
  exports["Monad"] = Monad;
  exports["Bind"] = Bind;
  exports["Applicative"] = Applicative;
  exports["Apply"] = Apply;
  exports["Functor"] = Functor;
  exports["=="] = $eq$eq;
  exports["eq"] = eq;
  exports["ap"] = ap;
  exports["return"] = $$return;
  exports[">>="] = $greater$greater$eq;
  exports["bind"] = bind;
  exports["liftA1"] = liftA1;
  exports["pure"] = pure;
  exports["apply"] = apply;
  exports["<$>"] = $less$dollar$greater;
  exports["map"] = map;
  exports["unit"] = unit;
  exports["eqString"] = eqString;;
 
})(PS["Prelude"] = PS["Prelude"] || {});
(function(exports) {
  // Generated by psc version 0.7.6.1
  "use strict";
  var $foreign = PS["Control.Monad.Eff"];
  var Prelude = PS["Prelude"];     
  var monadEff = new Prelude.Monad(function () {
      return applicativeEff;
  }, function () {
      return bindEff;
  });
  var bindEff = new Prelude.Bind(function () {
      return applyEff;
  }, $foreign.bindE);
  var applyEff = new Prelude.Apply(function () {
      return functorEff;
  }, Prelude.ap(monadEff));
  var applicativeEff = new Prelude.Applicative(function () {
      return applyEff;
  }, $foreign.returnE);
  var functorEff = new Prelude.Functor(Prelude.liftA1(applicativeEff));
  exports["functorEff"] = functorEff;
  exports["applyEff"] = applyEff;
  exports["applicativeEff"] = applicativeEff;
  exports["bindEff"] = bindEff;
  exports["monadEff"] = monadEff;;
 
})(PS["Control.Monad.Eff"] = PS["Control.Monad.Eff"] || {});
(function(exports) {
  /* global exports */
  "use strict";

  // module Control.Monad.Eff.JQuery

  exports.ready = function(func) {
      return function() {
          jQuery(document).ready(func);
      };
  };

  exports.select = function(selector) {
      return function() {
          return jQuery(selector);
      };
  };

  exports.css = function(props) {
      return function(ob) {
          return function() {
              return ob.css(props);
          };
      };
  };

  exports.toggleClass = function(cls) {
      return function(ob) {
          return function() {
              return ob.toggleClass(cls);
          };
      };
  };

  exports.setClass = function(cls) {
      return function(flag) {
          return function(ob) {
              return function() {
                  return ob.toggleClass(cls, flag);
              };
          };
      };
  };

  exports.before = function(ob) {
      return function(ob1) {
          return function() {
              return ob1.before(ob);
          };
      };
  };

  exports.on = function(evt) {
      return function(act) {
          return function(ob) {
              return function() {
                  return ob.on(evt, function(e) {
                      act(e)(jQuery(this))();
                  });
              };
          };
      };
  };

  exports.preventDefault = function(e) {
      return function() {
          e.preventDefault();
      };
  };
 
})(PS["Control.Monad.Eff.JQuery"] = PS["Control.Monad.Eff.JQuery"] || {});
(function(exports) {
  /* global exports */
  "use strict";

  exports.unsafeFromForeign = function (value) {
    return value;
  };

  exports.tagOf = function (value) {
    return Object.prototype.toString.call(value).slice(8, -1);
  };
 
})(PS["Data.Foreign"] = PS["Data.Foreign"] || {});
(function(exports) {
  // Generated by psc version 0.7.6.1
  "use strict";
  var Prelude = PS["Prelude"];
  var Control_Alt = PS["Control.Alt"];
  var Control_Extend = PS["Control.Extend"];
  var Data_Bifoldable = PS["Data.Bifoldable"];
  var Data_Bifunctor = PS["Data.Bifunctor"];
  var Data_Bitraversable = PS["Data.Bitraversable"];
  var Data_Foldable = PS["Data.Foldable"];
  var Data_Monoid = PS["Data.Monoid"];
  var Data_Traversable = PS["Data.Traversable"];     
  var Left = (function () {
      function Left(value0) {
          this.value0 = value0;
      };
      Left.create = function (value0) {
          return new Left(value0);
      };
      return Left;
  })();
  var Right = (function () {
      function Right(value0) {
          this.value0 = value0;
      };
      Right.create = function (value0) {
          return new Right(value0);
      };
      return Right;
  })();
  var functorEither = new Prelude.Functor(function (f) {
      return function (_2) {
          if (_2 instanceof Left) {
              return new Left(_2.value0);
          };
          if (_2 instanceof Right) {
              return new Right(f(_2.value0));
          };
          throw new Error("Failed pattern match at Data.Either line 52, column 1 - line 56, column 1: " + [ f.constructor.name, _2.constructor.name ]);
      };
  });
  var applyEither = new Prelude.Apply(function () {
      return functorEither;
  }, function (_4) {
      return function (r) {
          if (_4 instanceof Left) {
              return new Left(_4.value0);
          };
          if (_4 instanceof Right) {
              return Prelude["<$>"](functorEither)(_4.value0)(r);
          };
          throw new Error("Failed pattern match at Data.Either line 92, column 1 - line 116, column 1: " + [ _4.constructor.name, r.constructor.name ]);
      };
  });
  var applicativeEither = new Prelude.Applicative(function () {
      return applyEither;
  }, Right.create);
  exports["Left"] = Left;
  exports["Right"] = Right;
  exports["functorEither"] = functorEither;
  exports["applyEither"] = applyEither;
  exports["applicativeEither"] = applicativeEither;;
 
})(PS["Data.Either"] = PS["Data.Either"] || {});
(function(exports) {
  // Generated by psc version 0.7.6.1
  "use strict";
  var Prelude = PS["Prelude"];
  var Control_Alt = PS["Control.Alt"];
  var Control_Alternative = PS["Control.Alternative"];
  var Control_Extend = PS["Control.Extend"];
  var Control_MonadPlus = PS["Control.MonadPlus"];
  var Control_Plus = PS["Control.Plus"];
  var Data_Functor_Invariant = PS["Data.Functor.Invariant"];
  var Data_Monoid = PS["Data.Monoid"];     
  var Nothing = (function () {
      function Nothing() {

      };
      Nothing.value = new Nothing();
      return Nothing;
  })();
  exports["Nothing"] = Nothing;;
 
})(PS["Data.Maybe"] = PS["Data.Maybe"] || {});
(function(exports) {
  /* global exports */
  "use strict";

  exports.runFn2 = function (fn) {
    return function (a) {
      return function (b) {
        return fn(a, b);
      };
    };
  };
 
})(PS["Data.Function"] = PS["Data.Function"] || {});
(function(exports) {
  // Generated by psc version 0.7.6.1
  "use strict";
  var $foreign = PS["Data.Function"];
  var Prelude = PS["Prelude"];
  exports["runFn2"] = $foreign.runFn2;;
 
})(PS["Data.Function"] = PS["Data.Function"] || {});
(function(exports) {
  // Generated by psc version 0.7.6.1
  "use strict";
  var $foreign = PS["Data.Foreign"];
  var Prelude = PS["Prelude"];
  var Data_Either = PS["Data.Either"];
  var Data_Maybe = PS["Data.Maybe"];
  var Data_Function = PS["Data.Function"];
  var Data_Int = PS["Data.Int"];
  var Data_String = PS["Data.String"];     
  var TypeMismatch = (function () {
      function TypeMismatch(value0, value1) {
          this.value0 = value0;
          this.value1 = value1;
      };
      TypeMismatch.create = function (value0) {
          return function (value1) {
              return new TypeMismatch(value0, value1);
          };
      };
      return TypeMismatch;
  })();
  var unsafeReadTagged = function (tag) {
      return function (value) {
          if (Prelude["=="](Prelude.eqString)($foreign.tagOf(value))(tag)) {
              return Prelude.pure(Data_Either.applicativeEither)($foreign.unsafeFromForeign(value));
          };
          return new Data_Either.Left(new TypeMismatch(tag, $foreign.tagOf(value)));
      };
  }; 
  var readString = unsafeReadTagged("String");
  exports["TypeMismatch"] = TypeMismatch;
  exports["readString"] = readString;
  exports["unsafeReadTagged"] = unsafeReadTagged;;
 
})(PS["Data.Foreign"] = PS["Data.Foreign"] || {});
(function(exports) {
  // Generated by psc version 0.7.6.1
  "use strict";
  var $foreign = PS["Control.Monad.Eff.JQuery"];
  var Prelude = PS["Prelude"];
  var DOM = PS["DOM"];
  var Data_Foreign = PS["Data.Foreign"];
  var Control_Monad_Eff = PS["Control.Monad.Eff"];     
  var removeClass = function (cls) {
      return $foreign.setClass(cls)(false);
  };                                      
  var addClass = function (cls) {
      return $foreign.setClass(cls)(true);
  };
  exports["removeClass"] = removeClass;
  exports["addClass"] = addClass;
  exports["preventDefault"] = $foreign.preventDefault;
  exports["on"] = $foreign.on;
  exports["before"] = $foreign.before;
  exports["css"] = $foreign.css;
  exports["select"] = $foreign.select;
  exports["ready"] = $foreign.ready;;
 
})(PS["Control.Monad.Eff.JQuery"] = PS["Control.Monad.Eff.JQuery"] || {});
(function(exports) {
  'use strict';

  // module Control.Monad.Eff.JQuery.Typing

  exports.typing = function(settings) {
	  return function(ob) {
		  return function() {
			  ob.typing(settings);
		  }
	  }
  }
 
})(PS["Control.Monad.Eff.JQuery.Typing"] = PS["Control.Monad.Eff.JQuery.Typing"] || {});
(function(exports) {
  // Generated by psc version 0.7.6.1
  "use strict";
  var $foreign = PS["Control.Monad.Eff.JQuery.Typing"];
  var Prelude = PS["Prelude"];
  var Control_Monad_Eff = PS["Control.Monad.Eff"];
  var Control_Monad_Eff_JQuery = PS["Control.Monad.Eff.JQuery"];
  var Data_Maybe = PS["Data.Maybe"];
  var DOM = PS["DOM"];     
  var defaultTypingSettings = {
      sentences: [ "I'm a programmer", "Hello", "I'm Daniel", "I'm Daniel, and..", "I'm a programmer" ], 
      caretChar: "_", 
      caretClass: "typingjs__caret", 
      ignoreContent: false, 
      typeDelay: 50, 
      sentenceDelay: 750, 
      humanize: true, 
      onType: Data_Maybe.Nothing.value, 
      onBackspace: Data_Maybe.Nothing.value, 
      onFinish: Data_Maybe.Nothing.value, 
      onSentenceFinish: Data_Maybe.Nothing.value
  };
  exports["defaultTypingSettings"] = defaultTypingSettings;
  exports["typing"] = $foreign.typing;;
 
})(PS["Control.Monad.Eff.JQuery.Typing"] = PS["Control.Monad.Eff.JQuery.Typing"] || {});
(function(exports) {
  'use strict';

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
 
})(PS["Control.Monad.Eff.Throttle"] = PS["Control.Monad.Eff.Throttle"] || {});
(function(exports) {
  // Generated by psc version 0.7.6.1
  "use strict";
  var $foreign = PS["Control.Monad.Eff.Throttle"];
  var Prelude = PS["Prelude"];
  var Control_Monad_Eff = PS["Control.Monad.Eff"];
  var Data_Maybe = PS["Data.Maybe"];
  var Data_Function = PS["Data.Function"];     
  var throttle = Data_Function.runFn2($foreign.throttleImpl);
  exports["throttle"] = throttle;;
 
})(PS["Control.Monad.Eff.Throttle"] = PS["Control.Monad.Eff.Throttle"] || {});
(function(exports) {
  'use strict';

  // module Control.Monad.Eff.UUID

  exports.uuid = function() {
	  function s4() {
		  return Math.floor((1 + Math.random()) * 0x10000)
			  .toString(16)
			  .substring(1);
	  }
	  return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
		  s4() + '-' + s4() + s4() + s4();
  }
 
})(PS["Control.Monad.Eff.UUID"] = PS["Control.Monad.Eff.UUID"] || {});
(function(exports) {
  // Generated by psc version 0.7.6.1
  "use strict";
  var $foreign = PS["Control.Monad.Eff.UUID"];
  var Control_Monad_Eff = PS["Control.Monad.Eff"];
  var Control_Monad_Eff_Random = PS["Control.Monad.Eff.Random"];
  exports["uuid"] = $foreign.uuid;;
 
})(PS["Control.Monad.Eff.UUID"] = PS["Control.Monad.Eff.UUID"] || {});
(function(exports) {
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

  exports.smoothScroll = function(speed) {
	  return function(top) {
		  return function(ob) {
			  return function() {
				  return ob.animate({ scrollTop: top }, speed);
			  }
		  }
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
 
})(PS["UI.Import"] = PS["UI.Import"] || {});
(function(exports) {
  // Generated by psc version 0.7.6.1
  "use strict";
  var $foreign = PS["UI.Import"];
  var Prelude = PS["Prelude"];
  var Control_Monad_Eff = PS["Control.Monad.Eff"];
  var Control_Monad_Eff_JQuery = PS["Control.Monad.Eff.JQuery"];
  var Control_Monad_Eff_Random = PS["Control.Monad.Eff.Random"];
  var Data_Foreign = PS["Data.Foreign"];
  var DOM = PS["DOM"];
  var DOM_Timer = PS["DOM.Timer"];
  var Control_Monad_Eff_Throttle = PS["Control.Monad.Eff.Throttle"];
  var Control_Monad_Eff_UUID = PS["Control.Monad.Eff.UUID"];     
  var eventThrottled = function (callback) {
      return function (_8) {
          return function (_9) {
              return function __do() {
                  var _7 = callback();
                  return Prelude["return"](Control_Monad_Eff.applicativeEff)(Prelude.unit)();
              };
          };
      };
  };
  var mirrorHeight = function (updateInterval) {
      return function (target) {
          return function __do() {
              var _6 = $foreign.window();
              var _5 = Control_Monad_Eff_UUID.uuid();
              var _4 = $foreign.createEl("div")({
                  "class": "mirror", 
                  id: "mirror-" + _5
              })();
              return (function () {
                  var update = function __do() {
                      var _3 = $foreign.outerHeight(true)(target)();
                      Control_Monad_Eff_JQuery.css({
                          height: _3
                      })(_4)();
                      return Prelude["return"](Control_Monad_Eff.applicativeEff)(Prelude.unit)();
                  };
                  return function __do() {
                      Control_Monad_Eff_JQuery.on("resize")(eventThrottled(Control_Monad_Eff_Throttle.throttle(75)(update)))(_6)();
                      update();
                      return Prelude["return"](Control_Monad_Eff.applicativeEff)(_4)();
                  };
              })()();
          };
      };
  };
  var onScrollCheckpoint = function (delay) {
      return function (before) {
          return function (after) {
              return function (checkpoint) {
                  return function __do() {
                      var _2 = $foreign.document();
                      return (function () {
                          var onScroll = function __do() {
                              var _1 = $foreign.scrollTop(_2)();
                              var _0 = $foreign.offset(checkpoint)();
                              return (function () {
                                  var _18 = _1 < _0.top;
                                  if (_18) {
                                      return before;
                                  };
                                  if (!_18) {
                                      return after;
                                  };
                                  throw new Error("Failed pattern match at UI.Import line 41, column 17 - line 47, column 9: " + [ _18.constructor.name ]);
                              })()();
                          };
                          return function __do() {
                              Control_Monad_Eff_JQuery.on("scroll")(eventThrottled(Control_Monad_Eff_Throttle.throttle(delay)(onScroll)))(_2)();
                              onScroll();
                              return Prelude["return"](Control_Monad_Eff.applicativeEff)(checkpoint)();
                          };
                      })()();
                  };
              };
          };
      };
  };
  exports["mirrorHeight"] = mirrorHeight;
  exports["onScrollCheckpoint"] = onScrollCheckpoint;
  exports["eventThrottled"] = eventThrottled;
  exports["listToArray"] = $foreign.listToArray;
  exports["smoothScroll"] = $foreign.smoothScroll;
  exports["getAttr"] = $foreign.getAttr;
  exports["height"] = $foreign.height;
  exports["offset"] = $foreign.offset;
  exports["document"] = $foreign.document;
  exports["createEl"] = $foreign.createEl;;
 
})(PS["UI.Import"] = PS["UI.Import"] || {});
(function(exports) {
  // Generated by psc version 0.7.6.1
  "use strict";
  var Prelude = PS["Prelude"];
  var Control_Monad_Eff = PS["Control.Monad.Eff"];
  var Control_Monad_Eff_JQuery = PS["Control.Monad.Eff.JQuery"];
  var Control_Monad_Eff_Random = PS["Control.Monad.Eff.Random"];
  var Data_Foreign = PS["Data.Foreign"];
  var Data_Either = PS["Data.Either"];
  var DOM = PS["DOM"];
  var DOM_Timer = PS["DOM.Timer"];
  var UI_Import = PS["UI.Import"];     
  var smoothScrollMain = function __do() {
      var _12 = Control_Monad_Eff_JQuery.select("html")();
      var _11 = Control_Monad_Eff_JQuery.select("#main-nav")();
      var _10 = Control_Monad_Eff_JQuery.select("#main-nav ul li a, #go-page-top")();
      return (function () {
          var clicked = function (event) {
              return function (link) {
                  return function __do() {
                      var _9 = UI_Import.getAttr("href")(link)();
                      return (function () {
                          var _17 = Data_Foreign.readString(_9);
                          if (_17 instanceof Data_Either.Left) {
                              return Prelude["return"](Control_Monad_Eff.applicativeEff)(Prelude.unit);
                          };
                          if (_17 instanceof Data_Either.Right) {
                              return function __do() {
                                  Control_Monad_Eff_JQuery.preventDefault(event)();
                                  var _8 = UI_Import.height(_11)();
                                  var _7 = Prelude[">>="](Control_Monad_Eff.bindEff)(Control_Monad_Eff_JQuery.select(_17.value0))(UI_Import.offset)();
                                  UI_Import.smoothScroll(250)(_7.top - _8 - 16)(_12)();
                                  return Prelude["return"](Control_Monad_Eff.applicativeEff)(Prelude.unit)();
                              };
                          };
                          throw new Error("Failed pattern match at UI.Navigation line 64, column 13 - line 75, column 9: " + [ _17.constructor.name ]);
                      })()();
                  };
              };
          };
          return function __do() {
              Control_Monad_Eff_JQuery.on("click")(clicked)(_10)();
              return Prelude["return"](Control_Monad_Eff.applicativeEff)(Prelude.unit)();
          };
      })()();
  };
  var navbarMain = function __do() {
      var _4 = UI_Import.document();
      var _3 = Control_Monad_Eff_JQuery.select("#main-nav-wrapper")();
      var _2 = Control_Monad_Eff_JQuery.select("#main-nav")();
      var _1 = UI_Import.createEl("div")({
          id: "main-nav-checkpoint"
      })();
      Control_Monad_Eff_JQuery.before(_1)(_3)();
      var _0 = UI_Import.mirrorHeight(75)(_3)();
      Control_Monad_Eff_JQuery.before(_0)(_3)();
      var scrolledBefore = function __do() {
          Control_Monad_Eff_JQuery.removeClass("main-nav-wrapper--fixed")(_3)();
          return Control_Monad_Eff_JQuery.css({
              display: "none"
          })(_0)();
      };
      var scrolledAfter = function __do() {
          Control_Monad_Eff_JQuery.addClass("main-nav-wrapper--fixed")(_3)();
          return Control_Monad_Eff_JQuery.css({
              display: "block"
          })(_0)();
      };
      UI_Import.onScrollCheckpoint(75)(scrolledBefore)(scrolledAfter)(_1)();
      return Prelude["return"](Control_Monad_Eff.applicativeEff)(Prelude.unit)();
  };
  var goTopMain = function __do() {
      var _6 = Control_Monad_Eff_JQuery.select("#go-page-top")();
      var _5 = Control_Monad_Eff_JQuery.select("#main-nav-checkpoint")();
      return (function () {
          var scrolledBefore = Control_Monad_Eff_JQuery.addClass("go-page-top--hide")(_6);
          var scrolledAfter = Control_Monad_Eff_JQuery.removeClass("go-page-top--hide")(_6);
          return function __do() {
              UI_Import.onScrollCheckpoint(75)(scrolledBefore)(scrolledAfter)(_5)();
              return Prelude["return"](Control_Monad_Eff.applicativeEff)(Prelude.unit)();
          };
      })()();
  };
  var main = function __do() {
      navbarMain();
      goTopMain();
      return smoothScrollMain();
  };
  exports["main"] = main;;
 
})(PS["UI.Navigation"] = PS["UI.Navigation"] || {});
(function(exports) {
  // Generated by psc version 0.7.6.1
  "use strict";
  var Prelude = PS["Prelude"];
  var Control_Monad_Eff = PS["Control.Monad.Eff"];
  var Control_Monad_Eff_JQuery = PS["Control.Monad.Eff.JQuery"];
  var DOM = PS["DOM"];
  var Control_Monad_Eff_JQuery_Typing = PS["Control.Monad.Eff.JQuery.Typing"];
  var UI_Import = PS["UI.Import"];     
  var main = function __do() {
      var _1 = Control_Monad_Eff_JQuery.select("#tagline")();
      var _0 = Prelude[">>="](Control_Monad_Eff.bindEff)(Control_Monad_Eff_JQuery.select("#tagline-messages li"))(UI_Import.listToArray)();
      Control_Monad_Eff_JQuery_Typing.typing((function () {
          var _4 = {};
          for (var _5 in Control_Monad_Eff_JQuery_Typing.defaultTypingSettings) {
              if (Control_Monad_Eff_JQuery_Typing.defaultTypingSettings.hasOwnProperty(_5)) {
                  _4[_5] = Control_Monad_Eff_JQuery_Typing.defaultTypingSettings[_5];
              };
          };
          _4.sentences = _0;
          return _4;
      })())(_1)();
      return Prelude["return"](Control_Monad_Eff.applicativeEff)(Prelude.unit)();
  };
  exports["main"] = main;;
 
})(PS["UI.Tagline"] = PS["UI.Tagline"] || {});
(function(exports) {
  // Generated by psc version 0.7.6.1
  "use strict";
  var Prelude = PS["Prelude"];
  var Control_Monad_Eff = PS["Control.Monad.Eff"];
  var Control_Monad_Eff_JQuery = PS["Control.Monad.Eff.JQuery"];
  var Control_Monad_Eff_Random = PS["Control.Monad.Eff.Random"];
  var DOM = PS["DOM"];
  var DOM_Timer = PS["DOM.Timer"];
  var UI_Navigation = PS["UI.Navigation"];
  var UI_Tagline = PS["UI.Tagline"];     
  var main$prime = function __do() {
      UI_Navigation.main();
      UI_Tagline.main();
      return Prelude["return"](Control_Monad_Eff.applicativeEff)(Prelude.unit)();
  };
  var main = function __do() {
      Control_Monad_Eff_JQuery.ready(main$prime)();
      return Prelude["return"](Control_Monad_Eff.applicativeEff)(Prelude.unit)();
  };
  exports["main'"] = main$prime;
  exports["main"] = main;;
 
})(PS["Main"] = PS["Main"] || {});

PS["Main"].main();