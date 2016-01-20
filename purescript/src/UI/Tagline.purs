module UI.Tagline (main) where

import Prelude hiding (append)
import Control.Monad.Eff
import Control.Monad.Eff.JQuery (select)
import DOM(DOM())

import Control.Monad.Eff.JQuery.Typing
import UI.Import

main :: forall eff. Eff (dom :: DOM | eff) Unit
main = do
	tagline <- select "#tagline"
 	sentences <- select "#tagline-messages li" >>= listToArray
	typing (defaultTypingSettings {sentences = sentences}) tagline
 	return unit
