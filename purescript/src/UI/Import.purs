module UI.Import where

import Prelude hiding (append)
import Control.Monad.Eff
import Control.Monad.Eff.JQuery
import Control.Monad.Eff.Random
import Data.Maybe
import DOM(DOM())
import DOM.Timer

import Control.Monad.Eff.Throttle
import Control.Monad.Eff.UUID

type EventCallback = forall eff a. JQueryEvent -> JQuery -> Eff (dom :: DOM | eff) a

eventThrottledMaybe ::	forall eff.
	Throttled EventCallback
	-> JQueryEvent
	-> JQuery
	-> Eff (dom :: DOM | eff) Unit
eventThrottledMaybe callback event el = do
	fn <- callback
 	case fn of
		Nothing -> return unit
		Just fn -> fn event el >>= \_ -> return unit

eventThrottled :: forall eff a.
	Eff (dom :: DOM | eff) a
	-> JQueryEvent
	-> JQuery
	-> Eff(dom :: DOM | eff) Unit
eventThrottled callback _ _ = callback >>= \_ -> return unit

type Offset = {top :: Number, left :: Number}
foreign import createEl		 :: forall attr eff. String -> { | attr } -> Eff (dom :: DOM | eff) JQuery
foreign import window      :: forall eff. Eff (dom :: DOM | eff) JQuery
foreign import document    :: forall eff. Eff (dom :: DOM | eff) JQuery
foreign import offset      :: forall eff. JQuery -> Eff (dom :: DOM | eff) Offset
foreign import scrollTop   :: forall eff. JQuery -> Eff (dom :: DOM | eff) Number
foreign import outerHeight :: forall eff. Boolean -> JQuery -> Eff (dom :: DOM | eff) Int

{-- onScrollSection :: forall eff. EventCallback -> EventCallback -> JQuery -> Eff (dom :: DOM | eff) JQuery --}
{-- onScrollSection before after checkpoint = do --}
{-- 	doc <- document --}
{-- 	let --}
{--  		onScroll = do --}
{-- 		 	scrollTop <- scrollTop doc --}
{-- 			checkpointOffset <- offset checkpoint --}
{-- 	 		if scrollTop < checkpointOffset.top --}
{-- 			 	then before --}
{-- 		 		else after --}
{-- 	on "scroll" (eventThrottled (throttle 75 onScroll)) doc --}
{--  	return checkpoint --}

mirrorHeight :: forall eff. Int -> JQuery -> Eff (dom :: DOM, random :: RANDOM, timer :: Timer | eff) JQuery
mirrorHeight updateInterval el = do
	win <- window
	guid <- uuid
	mirror <- createEl "div" {class: "mirror", id: "mirror-" ++ guid}

	let update = do
		height <- outerHeight true el
		css {height: height} mirror
		return unit
	on "resize" (eventThrottled (throttle 75 update)) win
 	update

	return mirror
