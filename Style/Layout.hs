{-# LANGUAGE OverloadedStrings #-}

module Style.Layout (stylesheet) where

import Clay
import qualified Clay.Media as Q
import qualified Data.Monoid as M

import Style.Util.Import
import Style.Util.Mixins
import Style.Variables

stylesheet :: Css
stylesheet = do
  generalStyle
  gotoPageStyle
  aboutStyle
  toolsetStyle
  skillsetStyle
  experimentListStyle
  contactStyle
  footerStyle

generalStyle :: Css
generalStyle = do

  html M.<> body ? do
    backgroundColor colorWhite

  body ? do
    margin (px 0) 0 0 0
    padding (px 0) 0 0 0

  "#main-content" ? do
    let p = Clay.rem 2
    padding 0 p 0 p

  ".container" ? do
    margin (px 0) auto 0 auto
    maxWidth (px 1280)

  section # ".main-section" ? do
    marginBottom (Clay.rem 3)
    star # lastChild <? marginBottom (px 0)
    -- (h1 M.<> h2 M.<> h3 M.<> h4 M.<> h5 M.<> h6) # firstChild <? do
    --   textAlign $ alignSide sideCenter


gotoPageStyle :: Css
gotoPageStyle = do
  "#go-page-top" ? do
    let r = em 0.125
    position fixed
    padding (em 0.5) (em 1) (em 0.5) (em 1)
    bottom (px 0)
    right (px 0)
    color colorWhite
    fontWeight bold
    textDecoration none
    backgroundColor colorGray
    borderRadius r 0 0 0
    transitions [("background-color", ms 125, linear, ms 0), ("right", ms 250, linear, ms 0)]
    zIndex 9

    hover & do
      backgroundColor colorDarkGray

    query Q.screen [Q.minWidth breakSm] $ do
      padding (em 1) (em 1) (em 1) (em 1)
      bottom (em 1)
      right (em 1)
      borderRadius r r r r

    ".go-page-top--hide" & do
      right (pct (-25))

aboutStyle :: Css
aboutStyle = do
  query Q.screen [Q.minWidth breakMd] $ do
    "#about-text" ? do
      row
      "#about-developer" M.<> "#about-personal" ? do
        columnGrid 1 2

toolsetStyle :: Css
toolsetStyle = do
  ul # "#toolset" ? do
    noListStyle
    row
    margin (px 0) 0 0 0
    textAlign $ alignSide sideCenter

    li ? do
      width (pct 80)
      margin (em 2) auto (em 2) auto

      query Q.screen [Q.minWidth breakMd] $ do
        margin (em 3) 0 (em 3) 0
      query Q.screen [Q.minWidth breakMd, Q.maxWidth breakLg'] $ do
        columnGrid 1 2
      query Q.screen [Q.minWidth breakLg] $ do
        columnGrid 1 4

skillsetStyle :: Css
skillsetStyle= do
  "#skills__columns" ? do
    row
    "#skills__professional" M.<> "#skills__personal" ? do
      query Q.screen [Q.minWidth breakMd] $ column 1 2

    ul # ".skillset" ? do
      noListStyle
      margin (px 0) 0 0 0
      li ? do
        margin (em 2) 0 (em 2) 0

experimentListStyle :: Css
experimentListStyle = do

  "#experiment-list" ? do
    row

  "#experiment-list" |> li # ".experiment" ? do

    margin (em 2) auto (em 2) auto

    query Q.screen [Q.minWidth breakSm, Q.maxWidth breakLg'] $ do
      columnGrid 1 2
    query Q.screen [Q.minWidth breakLg] $ do
      columnGrid 1 3

    p # lastOfType ? marginBottom (em 0.5)

    ".experiment-tags" ? do
      li ? do
        display inlineBlock
        wordSpacing (em 1)
        a ? do
          let r = em 0.125
          padding (em 0.250) (em 0.250) (em 0.250) (em 0.250)
          borderRadius r r r r
          color colorWhite
          fontWeight bold
          textDecoration none
          backgroundColor colorGray
          transitions [("background-color", ms 125, linear, ms 0), ("right", ms 250, linear, ms 0)]
          hover & backgroundColor colorDarkGray

contactStyle :: Css
contactStyle = do

  "#contact-text" ? do
    query Q.screen [Q.minWidth breakMd] $ do
      row
      "#contact-about" ? do
        column 1 3
      "#contact-form" ? do
        column 2 3

  "#contact-form" ? do
    marginBottom (em 1.5)
    input # ("type" @= "email") M.<> input # ("type" @= "text") M.<> textarea ? do
      display block
      boxSizing borderBox
      marginBottom (em 1)
      width (pct 100)
      minWidth (pct 100)
      maxWidth (pct 100)
      "resize" -:  "none"

    textarea ? minHeight (px 240)

footerStyle :: Css
footerStyle = do
  footer ? do
    row
    padding (em 1) (em 2) (em 1) (em 2)
    fontFamily ["Open Sans"] [sansSerif]
    borderTop solid (px 1) colorLightGray
    color colorGray

    h1 M.<> h2 M.<> h3 M.<> h4 ? do
      marginBottom (px 0)
      small ? do
        fontWeight normal

    "#footer-lang" M.<> "#footer-nav" M.<> "#footer-copyright" ? do
      padding (em 1) 0 (em 1) 0
      textAlign $ alignSide sideCenter
      query Q.screen [Q.minWidth breakSm] $ do
        textAlign $ alignSide sideLeft
        columnRight 1 2

    a ? do
      textDecoration none

    p ? do
      marginBottom (px 0)
