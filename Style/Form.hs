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
    let r = em 0.125
    padding (em 0.5) (em 1) (em 0.5) (em 1)
    border solid (px 1) colorGray
    borderRadius r r r r
    fontWeight bold
    color colorWhite
    backgroundColor colorGray

    transitions
      [("background-color", ms 125, linear, 0)
      , ("color", ms 125, linear, 0)
      , ("border-color", ms 125, linear, 0)]

    hover & do
      borderColor colorLightGray
      backgroundColor colorLightGray
    active & do
      borderColor colorDarkGray
      backgroundColor colorDarkGray

fieldStyle :: Css
fieldStyle = do
  input # ("type" @= "text") M.<> input # ("type" @= "email") M.<> textarea ? do
    padding (em 1) (em 1) (em 1) (em 1)
    border none (px 0) transparent
    backgroundColor colorGray
    transition "background-color" (ms 75) linear 0
    focus & do
      outline solid (px 0) transparent
      backgroundColor colorLightGray

  textarea ? do
    fontFamily ["Open Sans"] [sansSerif]
