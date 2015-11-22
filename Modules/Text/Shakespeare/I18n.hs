module Text.Shakespeare.I18n
(
  hamletFilei18n,
  whamletFilei18n
) where

import Import.NoFoundation
import Language.Haskell.TH
import Text.Hamlet

-- Returns a function that takes a list of preferred languages and returns
-- the first one that matches the given list; returns default otherwise
hamletFilei18n :: FilePath -> [String] -> String -> Q Exp
hamletFilei18n _ [] _ = err
hamletFilei18n basename supportedLangs extension =
  [|
    let
      widgets@((_, defaultWidget):_)=  $(hamletMultifileSuffix  basename supportedLangs extension)
    in
      (\langs -> fromMaybe defaultWidget $ multiLookup langs widgets)
  |]

-- Returns a widget that matches the language preferred by the user, or the
-- default one (first one specified)
whamletFilei18n :: FilePath -> [String] -> String -> Q Exp
whamletFilei18n _ [] _ = err
whamletFilei18n basename supportedLangs extension =
  [| do
    langs <- (<$>) unpack <$> languages
    let
      widgets@((_, defaultWidget):_)= $(whamletMultifileSuffix  basename supportedLangs extension)
    fromMaybe defaultWidget $ multiLookup langs widgets
  |]

err :: Q Exp
err = error "At least 1 language has to be supported."

-- returns a list of hamlet files with the given suffixes
hamletMultifileSuffix :: FilePath -> [String] -> String -> Q Exp
hamletMultifileSuffix = shakespeareMultifileSuffix hamletFileSuffix

-- returns a list of whamlet files with the given suffixes
whamletMultifileSuffix :: FilePath -> [String] -> String -> Q Exp
whamletMultifileSuffix = shakespeareMultifileSuffix whamletFileSuffix

-- returns a hamletFile with given suffix
hamletFileSuffix :: FilePath -> String -> String -> Q Exp
hamletFileSuffix basename suffix extension =
    [| $(hamletFile $ basename ++ "-" ++ suffix ++ extension) |]

-- returns a whamletfile with given suffix
whamletFileSuffix :: FilePath -> String -> String -> Q Exp
whamletFileSuffix basename suffix extension =
    [| $(whamletFile $ basename ++ "-" ++ suffix ++ extension) |]

-- returns a list of shakespearean files of the same kind (hamlet, whamlet, etc) with given suffixes
shakespeareMultifileSuffix
  :: (FilePath -> String -> String -> Q Exp) -> FilePath -> [String] -> String -> Q Exp
shakespeareMultifileSuffix _ _ [] _ = [| [] |]
shakespeareMultifileSuffix f basename (x:xs) extension =
  [| (x, $(f basename x extension)) : $(shakespeareMultifileSuffix f basename xs extension) |]

-- Gets first element of the list
getFirst :: [Maybe a] -> Maybe a
getFirst [] = Nothing
getFirst (x:_) = x

-- Returns the first element that matches any of the given keys (in order)
multiLookup :: (Eq a, Ord a) => [a] -> [(a, b)] -> Maybe b
multiLookup ks xs = getFirst . filter (not . isNothing) $ [lookup k xs | k <- ks]
