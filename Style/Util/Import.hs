module Style.Util.Import where

import Clay.Size (Size, Abs, Rel, px)

-- Useful functions
clamp :: (Eq a, Ord a) => a -> a -> a -> a
clamp val low high = max low (min val high)

unormalize :: Float -> Integer -> Integer
unormalize val base =
  let delta = clamp val 0 1
  in floor $ (fromIntegral base) * delta
