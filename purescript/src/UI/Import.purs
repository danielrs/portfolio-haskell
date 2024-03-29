module UI.Import where

import Prelude hiding (append)
import Control.Monad.Eff
import Control.Monad.Eff.JQuery
import Control.Monad.Eff.Random
import Data.Foreign (Foreign())
import DOM(DOM())
import DOM.Timer

import Control.Monad.Eff.Throttle
import Control.Monad.Eff.UUID

-- Media break points

breakSm :: Int
breakSm = 480

breakMd :: Int
breakMd = 768

breakLg :: Int
breakLg = 1024

breakXl :: Int
breakXl = 1280

-- Event handling

type Callback eff a = Eff (dom :: DOM | eff) a

eventThrottled :: forall eff a.
	Eff (dom :: DOM | eff) a
	-> JQueryEvent
	-> JQuery
	-> Eff (dom :: DOM | eff) Unit
eventThrottled callback _ _ = callback >>= \_ -> return unit

onScrollCheckpoint ::
	forall a eff. Int -> Callback eff a -> Callback eff a -> JQuery -> Eff (dom :: DOM | eff) JQuery
onScrollCheckpoint delay before after checkpoint = do
	doc <- document
	let
 		onScroll = do
		 	scroll <- scrollTop doc
			checkpointOffset <- offset checkpoint
	 		if scroll < checkpointOffset.top
			 	then before
		 		else after
	on "scroll" (eventThrottled (throttle delay onScroll)) doc
 	onScroll
 	return checkpoint

-- jQuery

type Offset = {top :: Int, left :: Int}
foreign import createEl     :: forall attr eff. String -> { | attr } -> Eff (dom :: DOM | eff) JQuery
foreign import window       :: forall eff. Eff (dom :: DOM | eff) JQuery
foreign import document     :: forall eff. Eff (dom :: DOM | eff) JQuery
foreign import offset       :: forall eff. JQuery -> Eff (dom :: DOM | eff) Offset
foreign import scrollTop    :: forall eff. JQuery -> Eff (dom :: DOM | eff) Int
foreign import width        :: forall eff. JQuery -> Eff (dom :: DOM | eff) Int
foreign import height       :: forall eff. JQuery -> Eff (dom :: DOM | eff) Int
foreign import outerHeight  :: forall eff. Boolean -> JQuery -> Eff (dom :: DOM | eff) Int
foreign import getAttr      :: forall eff. String -> JQuery -> Eff (dom :: DOM | eff) Foreign
foreign import submit 			:: forall eff. JQuery -> Eff (dom :: DOM | eff) JQuery
foreign import animate 			:: forall prop eff. { | prop } -> Int -> JQuery -> Eff (dom :: DOM | eff) JQuery
foreign import animateStop  :: forall eff. JQuery -> Eff (dom :: DOM | eff) JQuery
foreign import listToArray  :: forall eff. JQuery -> Eff (dom :: DOM | eff) (Array String)
