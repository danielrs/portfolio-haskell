module Main where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.JQuery (ready, select)
import Control.Monad.Eff.Random
import DOM(DOM())
import DOM.Timer

import Control.Monad.Eff.JQuery.Typing

import qualified UI.Navbar as Navbar

main :: forall eff. Eff (dom :: DOM, random :: RANDOM, timer :: Timer | eff) Unit
main = do
	ready main'
 	return unit

main' :: forall eff. Eff (dom :: DOM, random :: RANDOM, timer :: Timer | eff) Unit
main' = do

	-- Tagline
	tagline <- select "#tagline"
 	typing defaultTypingSettings tagline

	-- Call main components
	Navbar.main

	return unit
