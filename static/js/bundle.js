// Generated by psc-bundle 0.8.0.0
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
  // Generated by psc version 0.8.0.0
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
  var unit = {};      
  var pure = function (dict) {
      return dict.pure;
  };
  var $$return = function (dictApplicative) {
      return pure(dictApplicative);
  };
  var map = function (dict) {
      return dict.map;
  };
  var $less$dollar$greater = function (dictFunctor) {
      return map(dictFunctor);
  };
  var bind = function (dict) {
      return dict.bind;
  };
  var $greater$greater$eq = function (dictBind) {
      return bind(dictBind);
  }; 
  var apply = function (dict) {
      return dict.apply;
  };
  var $less$times$greater = function (dictApply) {
      return apply(dictApply);
  };
  var liftA1 = function (dictApplicative) {
      return function (f) {
          return function (a) {
              return $less$times$greater(dictApplicative["__superclass_Prelude.Apply_0"]())(pure(dictApplicative)(f))(a);
          };
      };
  };
  var ap = function (dictMonad) {
      return function (f) {
          return function (a) {
              return bind(dictMonad["__superclass_Prelude.Bind_1"]())(f)(function (v) {
                  return bind(dictMonad["__superclass_Prelude.Bind_1"]())(a)(function (v1) {
                      return $$return(dictMonad["__superclass_Prelude.Applicative_0"]())(v(v1));
                  });
              });
          };
      };
  };
  exports["Monad"] = Monad;
  exports["Bind"] = Bind;
  exports["Applicative"] = Applicative;
  exports["Apply"] = Apply;
  exports["Functor"] = Functor;
  exports["ap"] = ap;
  exports[">>="] = $greater$greater$eq;
  exports["bind"] = bind;
  exports["liftA1"] = liftA1;
  exports["pure"] = pure;
  exports["apply"] = apply;
  exports["<$>"] = $less$dollar$greater;
  exports["map"] = map;
  exports["unit"] = unit;;
 
})(PS["Prelude"] = PS["Prelude"] || {});
(function(exports) {
  // Generated by psc version 0.8.0.0
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

  exports.find = function(selector) {
      return function(ob) {
          return function() {
              return ob.find(selector);
          };
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

  exports.remove = function(ob) {
      return function() {
          return ob.remove();
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
  // Generated by psc version 0.8.0.0
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
  var functorEither = new Prelude.Functor(function (v) {
      return function (v1) {
          if (v1 instanceof Left) {
              return new Left(v1.value0);
          };
          if (v1 instanceof Right) {
              return new Right(v(v1.value0));
          };
          throw new Error("Failed pattern match at Data.Either line 52, column 1 - line 56, column 1: " + [ v.constructor.name, v1.constructor.name ]);
      };
  });
  var applyEither = new Prelude.Apply(function () {
      return functorEither;
  }, function (v) {
      return function (v1) {
          if (v instanceof Left) {
              return new Left(v.value0);
          };
          if (v instanceof Right) {
              return Prelude["<$>"](functorEither)(v.value0)(v1);
          };
          throw new Error("Failed pattern match at Data.Either line 92, column 1 - line 116, column 1: " + [ v.constructor.name, v1.constructor.name ]);
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
  // Generated by psc version 0.8.0.0
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
  // Generated by psc version 0.8.0.0
  "use strict";
  var $foreign = PS["Data.Function"];
  var Prelude = PS["Prelude"];
  exports["runFn2"] = $foreign.runFn2;;
 
})(PS["Data.Function"] = PS["Data.Function"] || {});
(function(exports) {
  // Generated by psc version 0.8.0.0
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
          if ($foreign.tagOf(value) === tag) {
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
  // Generated by psc version 0.8.0.0
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
  exports["remove"] = $foreign.remove;
  exports["toggleClass"] = $foreign.toggleClass;
  exports["css"] = $foreign.css;
  exports["find"] = $foreign.find;
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
  // Generated by psc version 0.8.0.0
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
  // Generated by psc version 0.8.0.0
  "use strict";
  var $foreign = PS["Control.Monad.Eff.Throttle"];
  var Prelude = PS["Prelude"];
  var Control_Monad_Eff = PS["Control.Monad.Eff"];
  var Data_Function = PS["Data.Function"];     
  var throttle = Data_Function.runFn2($foreign.throttleImpl);
  exports["throttle"] = throttle;;
 
})(PS["Control.Monad.Eff.Throttle"] = PS["Control.Monad.Eff.Throttle"] || {});
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

  exports.width = function(ob) {
	  return function() {
		  return ob.width();
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

  exports.submit = function(ob) {
	  return function() {
		  return ob.submit();
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
 
})(PS["UI.Import"] = PS["UI.Import"] || {});
(function(exports) {
  // Generated by psc version 0.8.0.0
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
      return function (v) {
          return function (v1) {
              return function __do() {
                  var v2 = callback();
                  return Prelude.unit;
              };
          };
      };
  };
  var onScrollCheckpoint = function (delay) {
      return function (before) {
          return function (after) {
              return function (checkpoint) {
                  return function __do() {
                      var v = $foreign.document();
                      var onScroll = function __do() {
                          var v1 = $foreign.scrollTop(v)();
                          var v2 = $foreign.offset(checkpoint)();
                          var $10 = v1 < v2.top;
                          if ($10) {
                              return before();
                          };
                          if (!$10) {
                              return after();
                          };
                          throw new Error("Failed pattern match at UI.Import line 44, column 17 - line 50, column 9: " + [ $10.constructor.name ]);
                      };
                      Control_Monad_Eff_JQuery.on("scroll")(eventThrottled(Control_Monad_Eff_Throttle.throttle(delay)(onScroll)))(v)();
                      onScroll();
                      return checkpoint;
                  };
              };
          };
      };
  };                
  var breakMd = 768;
  exports["onScrollCheckpoint"] = onScrollCheckpoint;
  exports["eventThrottled"] = eventThrottled;
  exports["breakMd"] = breakMd;
  exports["listToArray"] = $foreign.listToArray;
  exports["animateStop"] = $foreign.animateStop;
  exports["animate"] = $foreign.animate;
  exports["submit"] = $foreign.submit;
  exports["getAttr"] = $foreign.getAttr;
  exports["outerHeight"] = $foreign.outerHeight;
  exports["height"] = $foreign.height;
  exports["width"] = $foreign.width;
  exports["scrollTop"] = $foreign.scrollTop;
  exports["offset"] = $foreign.offset;
  exports["document"] = $foreign.document;
  exports["window"] = $foreign.window;
  exports["createEl"] = $foreign.createEl;;
 
})(PS["UI.Import"] = PS["UI.Import"] || {});
(function(exports) {
  // Generated by psc version 0.8.0.0
  "use strict";
  var Prelude = PS["Prelude"];
  var Control_Monad_Eff = PS["Control.Monad.Eff"];
  var Control_Monad_Eff_JQuery = PS["Control.Monad.Eff.JQuery"];
  var Control_Monad_Eff_Random = PS["Control.Monad.Eff.Random"];
  var Data_Foreign = PS["Data.Foreign"];
  var Data_Either = PS["Data.Either"];
  var DOM = PS["DOM"];
  var DOM_Timer = PS["DOM.Timer"];
  var Control_Monad_Eff_Throttle = PS["Control.Monad.Eff.Throttle"];
  var UI_Import = PS["UI.Import"];     
  var smoothScroll = function __do() {
      var v = Control_Monad_Eff_JQuery.select("html, body")();
      var v1 = Control_Monad_Eff_JQuery.select("#main-nav")();
      var v2 = Control_Monad_Eff_JQuery.select("#main-nav ul li a, #go-page-top")();
      var clicked = function (event) {
          return function (link) {
              return function __do() {
                  var v3 = UI_Import.getAttr("href")(link)();
                  var $33 = Data_Foreign.readString(v3);
                  if ($33 instanceof Data_Either.Left) {
                      return Prelude.unit;
                  };
                  if ($33 instanceof Data_Either.Right) {
                      Control_Monad_Eff_JQuery.preventDefault(event)();
                      var v4 = Prelude[">>="](Control_Monad_Eff.bindEff)(Control_Monad_Eff_JQuery.select($33.value0))(UI_Import.offset)();
                      var v5 = (function __do() {
                          var w = UI_Import.width(v)();
                          var $36 = w > UI_Import.breakMd;
                          if ($36) {
                              return 0;
                          };
                          if (!$36) {
                              return UI_Import.height(v1)();
                          };
                          throw new Error("Failed pattern match at UI.Navigation line 95, column 7 - line 106, column 3: " + [ $36.constructor.name ]);
                      })();
                      Prelude[">>="](Control_Monad_Eff.bindEff)(UI_Import.animateStop(v))(UI_Import.animate({
                          scrollTop: v4.top - v5 - 32
                      })(250))();
                      return Prelude.unit;
                  };
                  throw new Error("Failed pattern match at UI.Navigation line 95, column 7 - line 106, column 3: " + [ $33.constructor.name ]);
              };
          };
      };
      Control_Monad_Eff_JQuery.on("click")(clicked)(v2)();
      return Prelude.unit;
  };
  var navbar = function __do() {
      var v = UI_Import.window();
      var v1 = UI_Import.document();
      var v2 = Control_Monad_Eff_JQuery.select("#main-nav-wrapper")();
      var v3 = Control_Monad_Eff_JQuery.select("#main-nav")();
      var v4 = Control_Monad_Eff_JQuery.select("#main-nav__toggle")();
      var v5 = UI_Import.createEl("div")({
          id: "main-nav-checkpoint"
      })();
      Control_Monad_Eff_JQuery.before(v5)(v2)();
      var v6 = UI_Import.createEl("div")({
          "class": "mirror", 
          id: "main-nav-mirror"
      })();
      Control_Monad_Eff_JQuery.before(v6)(v2)();
      var updateHeight = function __do() {
          var v7 = UI_Import.height(v3)();
          Control_Monad_Eff_JQuery.css({
              height: v7
          })(v2)();
          var v8 = UI_Import.outerHeight(true)(v2)();
          return Control_Monad_Eff_JQuery.css({
              height: v8
          })(v6)();
      };
      var toggled = function (v7) {
          return function (v8) {
              return function __do() {
                  Control_Monad_Eff_JQuery.toggleClass("main-nav-wrapper--hide-nav")(v2)();
                  return updateHeight();
              };
          };
      };
      var scrolledBefore = function __do() {
          Control_Monad_Eff_JQuery.removeClass("main-nav-wrapper--fixed")(v2)();
          Control_Monad_Eff_JQuery.css({
              display: "none"
          })(v6)();
          return updateHeight();
      };
      var scrolledAfter = function __do() {
          Control_Monad_Eff_JQuery.addClass("main-nav-wrapper--fixed")(v2)();
          Control_Monad_Eff_JQuery.css({
              display: "block"
          })(v6)();
          return updateHeight();
      };
      UI_Import.onScrollCheckpoint(75)(scrolledBefore)(scrolledAfter)(v5)();
      Control_Monad_Eff_JQuery.on("click")(toggled)(v4)();
      Control_Monad_Eff_JQuery.on("resize")(UI_Import.eventThrottled(Control_Monad_Eff_Throttle.throttle(75)(updateHeight)))(v)();
      return Prelude.unit;
  };
  var languageChange = function __do() {
      var v = Control_Monad_Eff_JQuery.select("#footer-lang form")();
      var v1 = Control_Monad_Eff_JQuery.find("select")(v)();
      Prelude[">>="](Control_Monad_Eff.bindEff)(Control_Monad_Eff_JQuery.find("input[type=submit]")(v))(Control_Monad_Eff_JQuery.remove)();
      var changed = function (v2) {
          return function (v3) {
              return UI_Import.submit(v);
          };
      };
      Control_Monad_Eff_JQuery.on("change")(changed)(v1)();
      return Prelude.unit;
  };
  var goTop = function __do() {
      var v = Control_Monad_Eff_JQuery.select("#go-page-top")();
      var v1 = Control_Monad_Eff_JQuery.select("#about-section")();
      var scrolledBefore = Control_Monad_Eff_JQuery.addClass("go-page-top--hide")(v);
      var scrolledAfter = Control_Monad_Eff_JQuery.removeClass("go-page-top--hide")(v);
      UI_Import.onScrollCheckpoint(75)(scrolledBefore)(scrolledAfter)(v1)();
      return Prelude.unit;
  };
  var aside = function __do() {
      var v = UI_Import.window();
      var v1 = UI_Import.document();
      var v2 = Control_Monad_Eff_JQuery.select("#aside")();
      var scrolled = function __do() {
          var v3 = UI_Import.scrollTop(v1)();
          return Control_Monad_Eff_JQuery.css({
              top: v3
          })(v2)();
      };
      Control_Monad_Eff_JQuery.on("scroll")(function (v3) {
          return function (v4) {
              return scrolled;
          };
      })(v1)();
      scrolled();
      return Prelude.unit;
  };
  var main = function __do() {
      aside();
      navbar();
      goTop();
      smoothScroll();
      return languageChange();
  };
  exports["main"] = main;;
 
})(PS["UI.Navigation"] = PS["UI.Navigation"] || {});
(function(exports) {
  // Generated by psc version 0.8.0.0
  "use strict";
  var Prelude = PS["Prelude"];
  var Control_Monad_Eff = PS["Control.Monad.Eff"];
  var Control_Monad_Eff_JQuery = PS["Control.Monad.Eff.JQuery"];
  var DOM = PS["DOM"];
  var Control_Monad_Eff_JQuery_Typing = PS["Control.Monad.Eff.JQuery.Typing"];
  var UI_Import = PS["UI.Import"];     
  var main = function __do() {
      var v = Control_Monad_Eff_JQuery.select("#tagline")();
      var v1 = Prelude[">>="](Control_Monad_Eff.bindEff)(Control_Monad_Eff_JQuery.select("#tagline-messages li"))(UI_Import.listToArray)();
      Control_Monad_Eff_JQuery_Typing.typing((function () {
          var $4 = {};
          for (var $5 in Control_Monad_Eff_JQuery_Typing.defaultTypingSettings) {
              if (Control_Monad_Eff_JQuery_Typing.defaultTypingSettings.hasOwnProperty($5)) {
                  $4[$5] = Control_Monad_Eff_JQuery_Typing.defaultTypingSettings[$5];
              };
          };
          $4.sentences = v1;
          return $4;
      })())(v)();
      return Prelude.unit;
  };
  exports["main"] = main;;
 
})(PS["UI.Tagline"] = PS["UI.Tagline"] || {});
(function(exports) {
  // Generated by psc version 0.8.0.0
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
      return Prelude.unit;
  };
  var main = function __do() {
      Control_Monad_Eff_JQuery.ready(main$prime)();
      return Prelude.unit;
  };
  exports["main'"] = main$prime;
  exports["main"] = main;;
 
})(PS["Main"] = PS["Main"] || {});

PS["Main"].main();