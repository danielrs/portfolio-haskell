module Main where

import Distribution.Simple
import Style.Main (stylesheet, writeStylesheet)

main = defaultMain
  writeStylesheet "static/css/style.css" stylesheet
