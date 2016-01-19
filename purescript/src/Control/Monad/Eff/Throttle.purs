module Control.Monad.Eff.Throttle where

import Prelude (Unit())
import Control.Monad.Eff (Eff())
import Data.Maybe
import Data.Function

type Throttled a = forall eff. Eff ( | eff) (Maybe a)

foreign import debounceImpl      :: forall eff a. Fn2 Int (Eff ( | eff) a) (Eff ( | eff) Unit)
foreign import debounceMaybeImpl :: forall a. Fn4 (Maybe a) (a -> Maybe a) Int a (Throttled a)
foreign import throttleImpl      :: forall eff a. Fn2 Int (Eff ( | eff) a) (Eff ( | eff) Unit)
foreign import throttleMaybeImpl :: forall a. Fn4 (Maybe a) (a -> Maybe a) Int a (Throttled a)

debounce :: forall eff a. Int -> Eff ( | eff) a -> Eff ( | eff) Unit
debounce = runFn2 debounceImpl

debounceMaybe :: forall a. Int -> a -> Throttled a
debounceMaybe = runFn4 debounceMaybeImpl Nothing Just

throttle :: forall eff a. Int -> Eff ( | eff) a -> Eff ( | eff) Unit
throttle = runFn2 throttleImpl

throttleMaybe :: forall a. Int -> a -> Throttled a
throttleMaybe = runFn4 throttleMaybeImpl Nothing Just
