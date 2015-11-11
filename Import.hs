module Import
    ( module Import
    ) where

import Foundation            as Import
import Import.NoFoundation   as Import

import Language.Haskell.TH

whamletLang :: String -> [String] -> Q Exp
whamletLang _ [] = error "At least 1 language has to be supported!"
whamletLang basename supportedLangs@(mainLang:_) =
  [|
    let
      lookupWidgetOr :: [String] -> (String -> Maybe Widget) -> Widget -> Widget
      lookupWidgetOr _ _ widget = widget
      lookupWidgetOr (lang:langs) runner widget =
        case runner lang of
          Nothing -> lookupWidgetOr langs runner widget
          Just widget -> widget
    in do
      langs <- (<$>) unpack <$> languages
      let
        runWidget = $(whamletLoader basename supportedLangs)
        Just defaultWidget = runWidget mainLang
      lookupWidgetOr langs runWidget defaultWidget
  |]

-- Returns a function that looks up a widget from a language
whamletLoader ::
  String -- basename
  -> [String] -- suffixes
  -> Q Exp
whamletLoader _ [] = [| const Nothing |]
whamletLoader basename (x:xs) =
  [|
    (\lang ->
      if lang == x then
        Just $ $(whamletFile $ "templates/" ++ basename ++ "-" ++ x ++ ".hamlet")
      else
        $(whamletLoader basename xs) lang
    ) :: String -> Maybe Widget
  |]
