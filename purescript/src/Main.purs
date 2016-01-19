module Main where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.JQuery (ready)
import Control.Monad.Eff.Random
import DOM(DOM())
import DOM.Timer

import qualified UI.Navbar as Navbar
import qualified UI.Tagline as Tagline

main :: forall eff. Eff (dom :: DOM, random :: RANDOM, timer :: Timer | eff) Unit
main = do
	ready main'
 	return unit

main' :: forall eff. Eff (dom :: DOM, random :: RANDOM, timer :: Timer | eff) Unit
main' = do
	-- Call main components
	Navbar.main
 	Tagline.main
	return unit
