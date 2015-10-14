{-# LANGUAGE OverloadedStrings #-}

module Style.Nav (stylesheet) where

import Clay
import qualified Clay.Media as M
import Style.Variables
import Style.Util.Mixins

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
      borderRadius rad rad rad rad
      backgroundColor colorLightGray
      query M.screen [M.minWidth breakSm] $ do
        maxWidth (px 160)
        maxHeight (px 160)
      query M.screen [M.minWidth breakMd] $ do
        maxWidth (px 256)
        maxHeight (px 256)

  "#name" ? do
    marginBottom (em 0.075)
    a ? do
      color colorDarkGray
      textDecoration none

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

  "#main-nav" ? do
    margin 0 0 (em 2) 0
    ul ? do
      display inlineBlock
      margin (px 0) 0 0 0
      padding (px 0) 0 0 0
      listStyle none none none

      li ? do
        display block
        margin (em 1) (em 2) (em 1) (em 2)
        transition "transform" (ms 125) linear 0

        hover & transform (scale 1.125 1.125)

        a ? do
          color colorGray
          textDecoration none
          hover & color colorDarkGray

        query M.screen [M.minWidth $ px 480] $ do
          display inlineBlock
