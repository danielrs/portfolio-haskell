{-# LANGUAGE TemplateHaskell #-}

module Style.Main where

import Clay
import System.IO (writeFile)
import Data.Text.Lazy (unpack)

import Language.Haskell.TH

-- Import all sub-styles here
import qualified Style.Form as Form
import qualified Style.Header as Header
import qualified Style.Text as Text
import qualified Style.Layout as Layout

stylesheet :: Css
stylesheet = do
  Text.stylesheet
  Form.stylesheet
  Header.stylesheet
  Layout.stylesheet

writeStylesheet :: FilePath -> Css -> IO ()
writeStylesheet file css =
  let rendered = unpack $ render css
  in writeFile file rendered

main :: IO ()
main = writeStylesheet "./static/css/style.css" stylesheet
