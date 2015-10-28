{-# LANGUAGE OverloadedStrings #-}

module Style.Header (stylesheet) where

import Clay
import qualified Clay.Media as Q
import Style.Variables
import Style.Util.Mixins
import qualified Data.Monoid as M

stylesheet :: Css
stylesheet = do

  header ? do
    padding (Clay.rem 2) (Clay.rem 2) 0 (Clay.rem 2)
    textAlign $ alignSide sideCenter

  "#profile" ? do
    margin 0 0 (em 1) 0
    img ? do
      let rad = pct 50
      display inlineBlock
      minWidth (px 128)
      minHeight (px 128)
      maxWidth (px 128)
      maxHeight (px 128)
      opacity 0.80
      -- borderRadius rad rad rad rad
      -- backgroundColor colorLightGray
      query Q.screen [Q.minWidth breakSm] $ do
        maxWidth (px 160)
        maxHeight (px 160)
      query Q.screen [Q.minWidth breakMd] $ do
        maxWidth (px 256)
        maxHeight (px 256)

  "#name" ? do
    marginBottom (em 0.050)
    a ? do
      color colorDarkGray
      textDecoration none
  "#tagline" ? do
    fontFamily ["Inconsolata"] [monospace]
    marginBottom (em 0.125)
    color colorGray


  "#social" ? do
    noListStyle
    display inlineBlock
    margin 0 0 (em 3) 0
    padding (em 0) 0 0 0
    li ? do
      display inlineBlock
      margin 0 (em 1) 0 (em 1)
      a ? do
        color colorGray
        hover & color colorDarkGray

  navbarStyle

navbarStyle :: Css
navbarStyle = do
  "#main-nav" ? do
    margin 0 0 (em 2) 0
    backgroundColor $ rgba 0 0 0 0
    transition "background-color" (ms 125) linear (ms 0)
    ul ? do
      display inlineBlock
      margin (px 0) 0 0 0
      padding (px 0) 0 0 0
      listStyle none none none

      li ? do
        display block
        margin (em 1) (em 2) (em 1) (em 2)
        transition "transform" (ms 125) linear (ms 0)

        hover & transform (scale 1.125 1.125)

        a ? do
          color colorGray
          textDecoration none
          hover & color colorDarkGray

        query Q.screen [Q.minWidth $ px 480] $ do
          display inlineBlock

  "#main-nav.main-nav--fixed" ? do
    position fixed
    top (px 0)
    left (px 0)
    right (px 0)
    backgroundColor colorGray
    zIndex 100
    ul Clay.** li Clay.** a ? do
      color colorLightGray
    ul Clay.** li Clay.** (a # hover M.<> a # ".main-nav__active") ? do
      color colorWhite
