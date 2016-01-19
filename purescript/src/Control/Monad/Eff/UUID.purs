module Control.Monad.Eff.UUID where

import Control.Monad.Eff
import Control.Monad.Eff.Random

type UUID = String

foreign import uuid :: forall eff. Eff (random :: RANDOM | eff) UUID
