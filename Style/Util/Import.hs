module Style.Util.Import where

import Clay.Color (Color(..), rgb)
import Clay.Size (Size, Abs, Rel, px)

import Data.Char (isHexDigit)
import Text.ParserCombinators.Parsec
import Numeric (readHex)

-- Useful variables
goldenRatio :: Double
goldenRatio = 1.6180

-- Useful functions
hexColor :: String -> Color
hexColor color =
   case parse parseHexColor "hexColor" color of
     Left err -> error $ show err
     Right color -> color

clamp :: (Eq a, Ord a) => a -> a -> a -> a
clamp val low high = max low (min val high)

unormalize :: Double -> Integer -> Integer
unormalize val base =
  let delta = clamp val 0 1
  in floor $ (fromIntegral base) * delta

goldenDelta :: Double -> Double
goldenDelta base = (1/goldenRatio) * base

-- Utility
parseHexColor :: Parser Color
parseHexColor = do
  let
    readHex' hex = fst . head $ readHex hex

  char '#'
  r <- count 2 (satisfy isHexDigit) >>= return . readHex'
  g <- count 2 (satisfy isHexDigit) >>= return . readHex'
  b <- count 2 (satisfy isHexDigit) >>= return . readHex'
  eof

  return $ rgb r g b
