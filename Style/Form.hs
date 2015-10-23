{-# LANGUAGE OverloadedStrings #-}

module Style.Form (stylesheet) where

import Clay
import qualified Clay.Media as Q
import qualified Data.Monoid as M

import Style.Util.Mixins
import Style.Variables

stylesheet :: Css
stylesheet = do
  buttonStyle
  fieldStyle


buttonStyle :: Css
buttonStyle = do
  input # ("type" @= "button")
  M.<> input # ("type" @= "submit")
  M.<> button ? do
    padding (em 0.5) (em 1) (em 0.5) (em 1)
    color colorGray
    backgroundColor transparent
    border solid (px 2) colorGray
    borderRadius (px 2) (px 2) (px 2) (px 2)

    transitions
      [("background-color", ms 75, linear, 0)
      , ("color", ms 75, linear, 0)
      , ("border-color", ms 75, linear, 0)]

    hover & do
      backgroundColor colorGray
      color colorBlack

    active & do
      backgroundColor colorLightGray
      borderColor colorLightGray

fieldStyle :: Css
fieldStyle = do
  input # ("type" @= "text") M.<> input # ("type" @= "email") M.<> textarea ? do
    padding (em 1) (em 1) (em 1) (em 1)
    border none (px 0) transparent
    backgroundColor colorGray
    transition "background-color" (ms 75) linear 0
    focus & do
      backgroundColor colorLightGray

  textarea ? do
    fontFamily ["Open Sans"] [sansSerif]
