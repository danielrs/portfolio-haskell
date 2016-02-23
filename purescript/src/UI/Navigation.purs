module UI.Navigation (main) where

import Prelude hiding (append)
import Control.Monad.Eff
import Control.Monad.Eff.JQuery
import Control.Monad.Eff.Random
import Data.Foreign
import Data.Either
import DOM (DOM())
import DOM.Timer

import Control.Monad.Eff.Throttle
import UI.Import

main :: forall eff. Eff (dom :: DOM, random :: RANDOM | eff) Unit
main = do
  aside
  navbar
  goTop
  smoothScroll
  languageChange

aside :: forall eff. Eff (dom :: DOM | eff) Unit
aside = do
  win <- window
  doc <- document
  aside <- select "#aside"

  let scrolled = do
        top <- scrollTop doc
        css {top: top} aside
  on "scroll" (\_ _ -> scrolled) doc
  scrolled

  return unit

navbar :: forall eff. Eff (dom :: DOM, random :: RANDOM | eff) Unit
navbar = do
  win <- window
  doc <- document

  mainNavWrapper <- select "#main-nav-wrapper"
  mainNav <- select "#main-nav"
  mainNavToggle <- select "#main-nav__toggle"

  checkpoint <- createEl "div" {id: "main-nav-checkpoint"}
  before checkpoint mainNavWrapper

  mirror <- createEl "div" {class: "mirror", id: "main-nav-mirror"}
  before mirror mainNavWrapper

  let
    updateHeight = do
      navHeight <- height mainNav
      css {height: navHeight} mainNavWrapper
      wrapperHeight <- outerHeight true mainNavWrapper
      css {height: wrapperHeight} mirror
    toggled _ _ = do
      toggleClass "main-nav-wrapper--hide-nav" mainNavWrapper
      updateHeight
    scrolledBefore = do
      removeClass "main-nav-wrapper--fixed" mainNavWrapper
      css {display: "none"} mirror
      updateHeight
    scrolledAfter = do
      addClass "main-nav-wrapper--fixed" mainNavWrapper
      css {display: "block"} mirror
      updateHeight
  onScrollCheckpoint 75 scrolledBefore scrolledAfter checkpoint
  on "click" toggled mainNavToggle
  on "resize" (eventThrottled (throttle 75 updateHeight)) win

  return unit

goTop :: forall eff. Eff (dom :: DOM | eff) Unit
goTop = do
  goTop <- select "#go-page-top"
  checkpoint <- select "#about-section"

  let
    scrolledBefore = do
      addClass "go-page-top--hide" goTop
    scrolledAfter = do
      removeClass "go-page-top--hide" goTop

  onScrollCheckpoint 75 scrolledBefore scrolledAfter checkpoint
  return unit

smoothScroll :: forall eff. Eff (dom :: DOM | eff) Unit
smoothScroll = do
  html <- select "html, body"
  mainNav <- select "#main-nav"
  links <- select "#main-nav ul li a, #go-page-top"

  let clicked event link = do
        fhref <- getAttr "href" link
        case readString fhref of
          Left _ -> return unit
          Right href -> do
            preventDefault event
            targetOffset <- select href >>= offset
            navHeight <- width html >>= \w -> if w > breakMd then return 0 else height mainNav
            animateStop html >>= animate {scrollTop: targetOffset.top - navHeight - 32} 250
            return unit

  on "click" clicked links
  return unit

languageChange :: forall eff. Eff (dom :: DOM | eff) Unit
languageChange = do
  form <- select "#footer-lang form"
  sel <- find "select" form
  find "input[type=submit]" form >>= remove

  let changed _ _ = submit form
  on "change" changed sel
  return unit
