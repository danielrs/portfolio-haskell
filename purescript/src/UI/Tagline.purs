module UI.Tagline (main) where

import Prelude hiding (append)
import Control.Monad.Eff
import Control.Monad.Eff.JQuery (select)
import DOM(DOM())

import Control.Monad.Eff.JQuery.Typing

sentences :: Array String
sentences = ["I'm a programmer", "Hello", "I'm Daniel", "I'm Daniel, and..", "I'm a programmer"]

main :: forall eff. Eff (dom :: DOM | eff) Unit
main = do
	tagline <- select "#tagline"
	typing (defaultTypingSettings {sentences = sentences}) tagline
 	return unit
