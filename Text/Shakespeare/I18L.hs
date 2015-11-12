module Text.Shakespeare.I18L
(
  hamletFilei18L,
  whamletFilei18L
) where

import Import.NoFoundation
import Language.Haskell.TH
import Text.Hamlet

-- Returns a function that takes a list of preferred languages and returns
-- the first one that matches the given list; returns default otherwise
hamletFilei18L :: String -> [String] -> Q Exp
hamletFilei18L _ [] = error "At least 1 language has to be supported."
hamletFilei18L basename supportedLangs =
  [|
    let
      widgets@((_, defaultWidget):_)=  $(hamletMultifileSuffix  basename supportedLangs)
    in
      (\langs ->
        case multiLookup langs widgets of
          Nothing -> defaultWidget
          Just widget -> widget
      )
  |]

-- Returns a widget that matches the language preferred by the user, or the
-- default one (first one specified)
whamletFilei18L :: String -> [String] -> Q Exp
whamletFilei18L _ [] = error "At least 1 language has to be supported."
whamletFilei18L basename supportedLangs =
  [|
    do
      langs <- (<$>) unpack <$> languages
      let
        widgets@((_, defaultWidget):_)= $(whamletMultifileSuffix  basename supportedLangs)
      case multiLookup langs widgets of
        Nothing -> defaultWidget
        Just widget -> widget
  |]

-- returns a list of hamlet files with the given suffixes
hamletMultifileSuffix :: String -> [String] -> Q Exp
hamletMultifileSuffix = shakespeareMultifileSuffix hamletFileSuffix

-- returns a list of whamlet files with the given suffixes
whamletMultifileSuffix :: String -> [String] -> Q Exp
whamletMultifileSuffix = shakespeareMultifileSuffix whamletFileSuffix

-- returns a hamletFile with given suffix
hamletFileSuffix :: String -> String -> Q Exp
hamletFileSuffix basename suffix =
    [| $(hamletFile $ basename ++ "-" ++ suffix ++ ".hamlet") |]

-- returns a whamletfile with given suffix
whamletFileSuffix :: String -> String -> Q Exp
whamletFileSuffix basename suffix =
    [| $(whamletFile $ basename ++ "-" ++ suffix ++ ".hamlet") |]

-- returns a list of shakespearean files of the same kind (hamlet, whamlet, etc) with given suffixes
shakespeareMultifileSuffix :: (String -> String -> Q Exp) -> String -> [String] -> Q Exp
shakespeareMultifileSuffix _ _ [] = [| [] |]
shakespeareMultifileSuffix f basename (x:xs) =
  [| (x, $(f basename x)) : $(shakespeareMultifileSuffix f basename xs) |]

-- Gets first element of the list
getFirst :: [Maybe a] -> Maybe a
getFirst [] = Nothing
getFirst (x:_) = x

-- Returns the first element that matches any of the given keys (in order)
multiLookup :: (Eq a, Ord a) => [a] -> [(a, b)] -> Maybe b
multiLookup ks xs = getFirst . filter (not . isNothing) $ [lookup k xs | k <- ks]
