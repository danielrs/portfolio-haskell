module Control.Monad.Eff.JQuery.Typing where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.JQuery (JQuery())
import Data.Maybe
import DOM (DOM())

type TypingSettings =
	{ sentences         :: Array String
  , caretChar        :: Char
	, caretClass       :: String
 	, ignoreContent    :: Boolean
	, typeDelay        :: Int
 	, sentenceDelay    :: Int
	, humanize         :: Boolean
  , onType           :: forall eff. Maybe (Eff (dom :: DOM | eff) Unit)
	, onBackspace      :: forall eff. Maybe (Eff (dom :: DOM | eff) Unit)
 	, onFinish         :: forall eff. Maybe (Eff (dom :: DOM | eff) Unit)
	, onSentenceFinish :: forall eff. Maybe (Eff (dom :: DOM | eff) Unit)}

defaultTypingSettings :: TypingSettings
defaultTypingSettings =
	{ sentences        : ["I'm a programmer", "Hello", "I'm Daniel", "I'm Daniel, and..", "I'm a programmer"]
	, caretChar        : '_'
	, caretClass       : "typingjs__caret"
	, ignoreContent    : false
	, typeDelay        : 50
	, sentenceDelay    : 750
	, humanize         : true
	, onType           : Nothing
	, onBackspace      : Nothing
	, onFinish         : Nothing
	, onSentenceFinish : Nothing }

foreign import typing :: forall eff. TypingSettings -> JQuery -> Eff (dom :: DOM | eff) JQuery
