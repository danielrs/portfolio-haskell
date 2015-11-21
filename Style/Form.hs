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
  selectStyle
  fieldStyle

buttonStyle :: Css
buttonStyle = do
  input # ("type" @= "button")
  M.<> input # ("type" @= "submit")
  M.<> button ? do
    let r = em 0.125
    padding (em 0.3) (em 0.5) (em 0.3) (em 0.5)
    fontSize (em 1)
    border solid (px 1) colorGray
    borderRadius r r r r
    color colorDarkGray
    backgroundColor colorLightGray

    transitions
      [("background-color", ms 125, linear, 0)
      , ("color", ms 125, linear, 0)
      , ("border-color", ms 125, linear, 0)]

    hover & do
      backgroundColor colorWhite
    active & do
      backgroundColor colorLightGray

selectStyle :: Css
selectStyle = do
  select ? do
    let r = em 0.125
    padding (em 0.25) (em 0.5) (em 0.25) (em 0.5)
    marginRight (em 0.125)

fieldStyle :: Css
fieldStyle = do
  input # ("type" @= "text") M.<> input # ("type" @= "email") M.<> textarea ? do
    padding (em 1) (em 1) (em 1) (em 1)
    fontSize (em 1)
    border solid (px 1) colorLightGray
    backgroundColor colorWhite
    transition "border-color" (ms 75) linear 0
    focus & do
      borderColor colorDarkGray
  textarea ? do
    fontFamily ["Open Sans"] [sansSerif]
