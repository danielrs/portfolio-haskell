module Style.Main where

import Clay
import System.IO (writeFile)
import Data.Text.Lazy (unpack)

-- Import all sub-styles here
import qualified Style.Form as Form
import qualified Style.Header as Header
import qualified Style.Layout as Layout
import qualified Style.Text as Text

writeStylesheet :: FilePath -> Css -> IO ()
writeStylesheet file css =
  let res = unpack $ render css
  in writeFile file res

writeStatic :: IO ()
writeStatic = writeStylesheet "../static/css/style.css" stylesheet

-- Add all sub-styles here
stylesheet :: Css
stylesheet = do
  Form.stylesheet
  Header.stylesheet
  Text.stylesheet
  Layout.stylesheet

main :: IO ()
main = do
  writeStatic
