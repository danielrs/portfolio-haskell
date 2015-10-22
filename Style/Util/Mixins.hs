{-# LANGUAGE OverloadedStrings #-}

module Style.Util.Mixins where

import Clay
import qualified Clay.Display as D
import Data.Text (pack)
import qualified Data.Monoid as M

import Style.Util.Import

-- See: http://stackoverflow.com/questions/211383/which-method-of-clearfix-is-best
clearfix :: Css
clearfix = do
  let common = do
      content $ stringContent ""
      display D.table
  before & common
  after & do
    common
    clear both
  "zoom" -: "1"

noListStyle :: Css
noListStyle = do
  margin (px 0) 0 0 0
  padding (px 0) 0 0 0
  listStyleType none
  listStyleImage none
  listStylePosition none
  li ? do
    margin (px 0) 0 0 0
    padding (px 0) 0 0 0
    listStyleType none
    listStyleImage none
    listStylePosition none

row :: Css
row = do
  display block
  boxSizing borderBox
  width (pct 100)
  clearfix

column :: Integer -> Integer -> Css
column colSpan totalCols = columnGap colSpan totalCols 28

columnGap :: Integer -> Integer -> Integer -> Css
columnGap colSpan totalCols baseGap = do
  let
    gap = (1 / fromIntegral totalCols) * fromIntegral baseGap
    widthLeft = 100 - gap * (fromIntegral totalCols - 1)
    columnWidth = (widthLeft / fromIntegral totalCols) * fromIntegral colSpan
  display block
  boxSizing borderBox
  float floatLeft
  width (pct columnWidth)
  marginRight (pct gap)
  lastChild & marginRight (px 0)

each :: Integer -> Css -> Css
each n css =
  let txt = pack $ show n ++ "n"
  in nthChild txt & css
