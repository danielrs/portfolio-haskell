{-# LANGUAGE OverloadedStrings #-}

module Style.Nav (stylesheet) where

import Clay
import qualified Clay.Media as M
import Style.Variables

stylesheet :: Css
stylesheet = do

  "#profile" ? do
    textAlign $ alignSide sideCenter
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
    textAlign $ alignSide sideCenter
    a ? do
      color colorDarkGray
      textDecoration none

  "#main-nav" ? do
    textAlign $ alignSide sideCenter
    margin (em 2) 0 (em 2) 0
    ul ? do
      display inlineBlock
      margin (px 0) 0 0 0
      padding (px 0) 0 0 0
      listStyle none none none

      li ? do
        display block
        margin (em 1) (em 2) (em 1) (em 2)
        transition "transform" (ms 125) linear 0

        hover & transform (scale 1.250 1.250)

        a ? do
          color colorGray
          textDecoration none
          transition "color" (ms 125) linear 0
          hover & color colorDarkGray

        query M.screen [M.minWidth $ px 480] $ do
          display inlineBlock
