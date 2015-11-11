module Text.Shakespeare.I18L
(
  hamletFilei18L,
  whamletFilei18L
) where

import Import.NoFoundation
import Language.Haskell.TH
import Text.Hamlet

-- Main
hamletFilei18L :: String -> [String] -> Q Exp
hamletFilei18L _ [] = error "At least 1 language has to be supported."
hamletFilei18L basename supportedLangs =
  [|
    let
      widgets@((_, defaultWidget):_)= $(hamletFilesSuffix  basename supportedLangs)
    in
      (\langs ->
        case multiLookup langs widgets of
          Nothing -> defaultWidget
          Just widget -> widget
      )
  |]

whamletFilei18L :: String -> [String] -> Q Exp
whamletFilei18L _ [] = error "At least 1 language has to be supported."
whamletFilei18L basename supportedLangs =
  [|
    do
      langs <- (<$>) unpack <$> languages
      let
        widgets@((_, defaultWidget):_)= $(whamletFilesSuffix  basename supportedLangs)
      case multiLookup langs widgets of
        Nothing -> defaultWidget
        Just widget -> widget
  |]

-- Utility functions
firstOrNothing :: [Maybe a] -> Maybe a
firstOrNothing [] = Nothing
firstOrNothing (x:_) = x

multiLookup :: (Eq a, Ord a) => [a] -> [(a, b)] -> Maybe b
multiLookup ks xs = firstOrNothing [lookup k xs | k <- ks]

-- Functions
hamletFileSuffix :: String -> String -> Q Exp
hamletFileSuffix basename suffix =
    [| $(hamletFile $ basename ++ "-" ++ suffix ++ ".hamlet") |]

whamletFileSuffix :: String -> String -> Q Exp
whamletFileSuffix basename suffix =
    [| $(whamletFile $ basename ++ "-" ++ suffix ++ ".hamlet") |]

hamletFilesSuffix :: String -> [String] -> Q Exp
hamletFilesSuffix _ [] = [| [] |]
hamletFilesSuffix basename (x:xs) =
  [| (x, $(hamletFileSuffix basename x)) : $(hamletFilesSuffix basename xs) |]

whamletFilesSuffix :: String -> [String] -> Q Exp
whamletFilesSuffix _ [] = [| [] |]
whamletFilesSuffix basename (x:xs) =
  [| (x, $(whamletFileSuffix basename x)) : $(whamletFilesSuffix basename xs) |]
