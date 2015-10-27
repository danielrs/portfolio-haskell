{-# LANGUAGE OverloadedStrings #-}

module Style.Text (stylesheet) where
import Clay
import qualified Clay.Elements as E
import qualified Clay.Media as Q
import qualified Data.Monoid as M

import Style.Variables
import Style.Util.Mixins

stylesheet :: Css
stylesheet = do
  defaultStyle
  blackSectionStyle
  notificationStyle

defaultStyle :: Css
defaultStyle = do
  importUrl "https://fonts.googleapis.com/css?family=Open+Sans:400,400italic,700|Slabo+27px|Inconsolata:400,700"
  body ? do
    -- fontSize (em 1.125)
    fontFamily ["Open Sans"] [sansSerif]
    color colorBlack

  h1 ? fontSize (em 2.250)
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
    transition "color" (ms 125) linear (ms 0)
    visited & color colorGray
    hover & color colorBlack
    active & color colorBlack

  ul ? do
    noListStyle

blackSectionStyle :: Css
blackSectionStyle = do
  ".black-section" ? do
    h4 ? do
      color colorGray

    a ? do
      color colorLightGray
      visited & color colorLightGray
      hover & color colorWhite
      active & color colorWhite

notificationStyle :: Css
notificationStyle = do
  "#message" ? do
    let r = em 0.125
    textAlign $ alignSide sideCenter
    E.span ? do
      display inlineBlock
      padding (em 0.5) (em 1) (em 0.5) (em 1)
      fontWeight bold
      color colorWhite
      backgroundColor colorGray
      borderRadius r r r r

  "#message.message--fixed" ? do
    position fixed
    bottom (em 4)
    left (pct 5)
    right (pct 5)
    zIndex 100

    query Q.screen [Q.minWidth breakSm] $ do
      left (pct 25)
      right (pct 25)
