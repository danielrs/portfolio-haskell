module Style.Util.Import where

import Clay.Size (Size, Abs, Rel, px)

-- Useful variables
goldenRatio :: Double
goldenRatio = 1.6180

-- Useful functions
clamp :: (Eq a, Ord a) => a -> a -> a -> a
clamp val low high = max low (min val high)

unormalize :: Double -> Integer -> Integer
unormalize val base =
  let delta = clamp val 0 1
  in floor $ (fromIntegral base) * delta

goldenDelta :: Double -> Double
goldenDelta base = (1/goldenRatio) * base
