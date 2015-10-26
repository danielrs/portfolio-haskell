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
column = columnLeft

columnGap :: Integer -> Integer -> Integer -> Css
columnGap colSpan totalCols baseGap = do
  let
    totalGaps = totalCols - 1
    gap = (1 / fromIntegral totalCols) * fromIntegral baseGap
    widthLeft = 100 - gap * fromIntegral totalGaps
    columnWidth = widthLeft / fromIntegral totalCols
    spannedWidth = columnWidth * fromIntegral colSpan + gap * fromIntegral (colSpan - 1)
  columnRaw
  width (pct spannedWidth)
  marginRight (pct gap)

columnRaw :: Css
columnRaw = do
  display block
  boxSizing borderBox

columnLeft :: Integer -> Integer -> Css
columnLeft colSpan totalCols = do
  columnGap colSpan totalCols 12
  float floatLeft
  lastChild & marginRight (px 0)

columnRight :: Integer -> Integer -> Css
columnRight colSpan totalCols = do
  columnGap colSpan totalCols 12
  float floatRight
  firstChild & marginRight (px 0)

each :: Integer -> Css -> Css
each n css =
  let txt = pack $ show n ++ "n"
  in nthChild txt & css
