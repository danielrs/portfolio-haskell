{-# LANGUAGE OverloadedStrings #-}

module Style.Header (stylesheet) where

import Clay
import qualified Clay.Media as Q
import Style.Util.Mixins
import Style.Util.Settings
import qualified Data.Monoid as M

stylesheet :: Css
stylesheet = do

  "#header" ? do
    textAlign $ alignSide sideCenter
    query Q.screen [Q.minWidth breakMd] $ textAlign $ alignSide sideRight

  profileStyle
  taglineStyle
  socialStyle
  navbarStyle

profileStyle :: Css
profileStyle = do
  "#profile" ? do
    margin 0 0 (em 1) 0
    img ? do
      let rad = pct 50
          side = em 10
      display inlineBlock
      minWidth side
      minHeight side
      maxWidth side
      maxHeight side
      opacity 0.80
  "#name" ? do
    marginBottom (em 0.050)
    a ? do
      fontFamily ["Pacifico"] [cursive]
      fontWeight normal
      color colorDarkGray
      textDecoration none

taglineStyle :: Css
taglineStyle = do
  "#tagline" ? do
    fontFamily ["Inconsolata"] [monospace]
    fontWeight normal
    marginBottom (em 0.125)
    color colorGray
  "#tagline-messages" ? do
    display none

socialStyle :: Css
socialStyle = do
  "#social" ? do
    noListStyle
    display inlineBlock
    margin 0 0 (em 3) 0
    padding (em 0) 0 0 0
    fontSize (em 0.85)
    li ? do
      display inlineBlock
      margin 0 (em 1) 0 (em 1)
      a ? do
        color colorGray
        hover & color colorDarkGray

navbarStyle :: Css
navbarStyle = do

  -- NORMAL
  "#main-nav-wrapper" ? do
    clearfix -- prevent margin collapse
    margin 0 0 (em 4) 0
    "#main-nav" ? do
      position relative
      top (pct 0)
      margin (px 0) 0 0 0
      backgroundColor $ rgba 0 0 0 0
      transition "top" (ms 125) linear (ms 0)
      ul ? do
        display inlineBlock
        margin (px 0) 0 0 0
        padding (px 0) 0 0 0
        listStyle none none none

        li ? do
          let p = em 1
          display block
          margin p p p p
          transition "transform" (ms 125) linear (ms 0)

          hover & transform (scale 1.125 1.125)

          a ? do
            color colorGray
            textDecoration none
            hover & color colorDarkGray

          query Q.screen [Q.minWidth breakSm, Q.maxWidth breakMd'] $ display inlineBlock
          query Q.screen [Q.minWidth breakMd] $ margin p 0 p 0

    "#main-nav__toggle" ? do
      let
        r = em 0.125
        p = em 0.250
      display none
      cursor pointer
      position absolute
      top (pct 100)
      right (em 1)
      padding p p p p
      borderRadius 0 0 r r
      textAlign $ alignSide sideCenter
      backgroundColor colorLightGray
      transition "background-color" speedFast linear (ms 0)
      zIndex 100
      hover & backgroundColor colorDarkGray
    "#main-nav__arrow" ? do
      let r = em 0.125
      position relative
      display inlineBlock
      top (em (-0.5))
      border solid (em 0.75) transparent
      borderLeftWidth (em 1)
      borderRightWidth (em 1)
      borderBottomColor colorWhite
      borderRadius r r r r

  -- FIXED
  "#main-nav-wrapper.main-nav-wrapper--fixed" ? do
    query Q.screen [Q.maxWidth breakMd'] $ do
      position fixed
      top (px 0)
      left (px 0)
      right (px 0)
      zIndex 100
      "#main-nav" ? do
        backgroundColor colorWhite
        borderBottom solid (px 1) colorLightGray
      "#main-nav__toggle" ? do
        display block

  -- FIXED HIDDEN
  "#main-nav-wrapper.main-nav-wrapper--fixed.main-nav-wrapper--hide-nav" ? do
    query Q.screen [Q.maxWidth breakMd'] $ do
      pointerEvents none
      "#main-nav" ? do
        pointerEvents auto
        top (pct (-100))
      "#main-nav__arrow" ? do
        top (em 0.5)
        borderBottomColor transparent
        borderTopColor colorWhite
