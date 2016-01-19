module UI.Navbar (main) where

import Prelude hiding (append)
import Control.Monad.Eff
import Control.Monad.Eff.JQuery
import Control.Monad.Eff.Random
import DOM (DOM())
import DOM.Timer

import Control.Monad.Eff.Throttle

import UI.Import

main :: forall eff. Eff (dom :: DOM, random :: RANDOM, timer :: Timer | eff) Unit
main = do
	bdy <- body
	doc <- document

 	mainNavWrapper <- select "#main-nav-wrapper"
	mainNav <- select "#main-nav"

	checkpoint <- createEl "div" {id: "main-nav-checkpoint"}
	before checkpoint mainNavWrapper

	mirror <- mirrorHeight 75 mainNavWrapper
 	css {display: "none"} mirror
	before mirror mainNavWrapper

	let
		onScroll = do
			scrollTop <- scrollTop doc
	 		checkpointOffset <- offset checkpoint
			if scrollTop < checkpointOffset.top
				then scrolledBefore
				else scrolledAfter
		scrolledBefore = do
	 		removeClass "main-nav-wrapper--fixed" mainNavWrapper
			css {display: "none"} mirror
			return unit
		scrolledAfter = do
	 		addClass "main-nav-wrapper--fixed" mainNavWrapper
			css {display: "block"} mirror
			return unit
	on "scroll" (eventThrottled (throttle 75 onScroll)) doc
 	onScroll

	return unit
