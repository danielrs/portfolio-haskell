module Control.Monad.Eff.Throttle where

import Prelude (Unit())
import Control.Monad.Eff (Eff())
import Data.Function

foreign import debounceImpl      :: forall eff a. Fn2 Int (Eff ( | eff) a) (Eff ( | eff) Unit)
foreign import throttleImpl      :: forall eff a. Fn2 Int (Eff ( | eff) a) (Eff ( | eff) Unit)

debounce :: forall eff a. Int -> Eff ( | eff) a -> Eff ( | eff) Unit
debounce = runFn2 debounceImpl

throttle :: forall eff a. Int -> Eff ( | eff) a -> Eff ( | eff) Unit
throttle = runFn2 throttleImpl
