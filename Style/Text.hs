{-# LANGUAGE OverloadedStrings #-}

module Style.Text (stylesheet) where
import Clay
import qualified Clay.Elements as E
import qualified Data.Monoid as M

import Style.Variables
import Style.Util.Mixins

stylesheet :: Css
stylesheet = do
  defaultStyles
  blackSectionStyles

defaultStyles :: Css
defaultStyles = do
  importUrl "https://fonts.googleapis.com/css?family=Open+Sans:400,400italic,700|Slabo+27px"

  body ? do
    fontSize (em 1.25)
    fontFamily ["Open Sans"] [sansSerif]

  h1 ? fontSize (em 2.125)
  h2 ? fontSize (em 2)
  h1 M.<> h2 ? do
    fontFamily ["Slabo 27px"] [serif]
    margin 0 0 (em 2) 0

  h3 M.<> h4 ? do
    fontFamily ["Open Sans"] [sansSerif]
    margin 0 0 (em 1.5) 0

  h4 ? do
    color colorGray
    ".black-section" & color colorLightGray

  h5 M.<> h6 ? do
    margin 0 0 (em 1) 0

  p ? do
    margin 0 0 (em 1.5) 0
    lineHeight (em 1.5)

  E.em ? do
    fontStyle italic

  strong ? do
    fontWeight bold

  a ? do
    fontFamily ["Slabo 27px"] [serif]
    color colorDarkGray
    transition "color" (ms 125) linear 0
    visited & color colorGray
    hover & color colorBlack
    active & color colorBlack

  ul ? do
    noListStyle

  footer ? do
    fontFamily ["Open Sans"] [sansSerif]
    fontWeight bold

blackSectionStyles :: Css
blackSectionStyles = do
  ".black-section" ? do
    h4 ? do
      color colorGray

    a ? do
      color colorLightGray
      visited & color colorLightGray
      hover & color colorWhite
      active & color colorWhite
