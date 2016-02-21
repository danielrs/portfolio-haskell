{-# LANGUAGE OverloadedStrings #-}
module Style.Text (stylesheet) where

import Clay
import qualified Clay.Elements as E
import qualified Clay.Media as Q
import qualified Data.Monoid as M

import Style.Util.Mixins
import Style.Util.Settings

stylesheet :: Css
stylesheet = do
  defaultStyle
  notificationStyle

defaultStyle :: Css
defaultStyle = do
  importUrl "https://fonts.googleapis.com/css?family=Pacifico|Open+Sans:400,400italic,700|Roboto+Slab:400,700|Inconsolata:400,700"

  body ? do
    fontSize (em 1.1)
    fontFamily ["Open Sans"] [sansSerif]
    color colorBlack

  h1 ? fontSize (em 2.250)
  h2 ? fontSize (em 2)

  h1 M.<> h2 M.<> h3 M.<> h4 ? do
    margin 0 0 (em 1.5) 0
  h4 ? do
    color colorDarkGray

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
    color colorDarkGray
    transition "color" (ms 125) linear (ms 0)
    visited & color colorGray
    hover & color colorBlack
    active & color colorBlack

  ul ? do
    noListStyle
    marginBottom (em 1.5)

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
