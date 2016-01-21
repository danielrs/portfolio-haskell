module UI.Navigation (main) where

import Prelude hiding (append)
import Control.Monad.Eff
import Control.Monad.Eff.JQuery
import Control.Monad.Eff.Random
import Data.Foreign
import Data.Either
import DOM (DOM())
import DOM.Timer

import Control.Monad.Eff.Throttle
import UI.Import

main :: forall eff. Eff (dom :: DOM, random :: RANDOM, timer :: Timer | eff) Unit
main = do
	navbarMain
 	goTopMain
	smoothScrollMain

navbarMain :: forall eff. Eff (dom :: DOM, random :: RANDOM, timer :: Timer | eff) Unit
navbarMain = do
	win <- window
	doc <- document

 	mainNavWrapper <- select "#main-nav-wrapper"
	mainNav <- select "#main-nav"
 	mainNavToggle <- select "#main-nav__toggle"

	checkpoint <- createEl "div" {id: "main-nav-checkpoint"}
	before checkpoint mainNavWrapper

	mirror <- mirrorHeight 75 mainNavWrapper
	before mirror mainNavWrapper

	let
 		updateHeight = do
		 	navHeight <- height mainNav
			css {height: navHeight} mainNavWrapper
 		toggled _ _ = do
		 	toggleClass "main-nav-wrapper--hide-nav" mainNavWrapper
			updateHeight
		scrolledBefore = do
			removeClass "main-nav-wrapper--fixed" mainNavWrapper
			css {display: "none"} mirror
	 		updateHeight
		scrolledAfter = do
			addClass "main-nav-wrapper--fixed" mainNavWrapper
			css {display: "block"} mirror
	 		updateHeight
 	onScrollCheckpoint 75 scrolledBefore scrolledAfter checkpoint
	on "click" toggled mainNavToggle
	on "resize" (eventThrottled (throttle 75 updateHeight)) win

	return unit

goTopMain :: forall eff. Eff (dom :: DOM | eff) Unit
goTopMain = do
	goTop <- select "#go-page-top"
	checkpoint <- select "#main-nav-checkpoint"

	let
 		scrolledBefore = do
			addClass "go-page-top--hide" goTop
		scrolledAfter = do
			removeClass "go-page-top--hide" goTop

	onScrollCheckpoint 75 scrolledBefore scrolledAfter checkpoint
	return unit

smoothScrollMain :: forall eff. Eff (dom :: DOM | eff) Unit
smoothScrollMain = do
	html <- select "html, body"
	mainNav <- select "#main-nav"
	links <- select "#main-nav ul li a, #go-page-top"

	let clicked event link = do
		fhref <- getAttr "href" link
		case readString fhref of
			Left _ -> return unit
			Right href -> do
				preventDefault event
				navHeight <- height mainNav
				targetOffset <- select href >>= offset
				animateStop html >>= animate {scrollTop: targetOffset.top - navHeight - 16} 250
				return unit

	on "click" clicked links
	return unit
