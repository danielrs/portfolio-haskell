{-# LANGUAGE OverloadedStrings #-}

module Style.Util.Mixins where

import Clay
import qualified Clay.Display as D
import Data.Text (pack)
import qualified Data.Monoid as M

import Style.Util.Import
import Style.Util.Settings

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

softButtonBase :: Css
softButtonBase = do
  color colorWhite
  backgroundColor colorGray
  transition "background-color" speedFast linear (ms 0)
  hover & backgroundColor colorDarkGray

--
-- GRID SYSTEM
--

row :: Css
row = do
  display block
  boxSizing borderBox
  width (pct 100)
  clearfix

column :: Integer -> Integer -> Css
column = columnLeft

columnLeft :: Integer -> Integer -> Css
columnLeft = columnGap True 12

columnRight :: Integer -> Integer -> Css
columnRight = columnGap False 12

columnRaw :: Css
columnRaw = do
  display block
  boxSizing borderBox

columnGrid :: Integer -> Integer -> Css
columnGrid = columnLeftGrid

columnGap :: Bool -> Integer -> Integer -> Integer -> Css
columnGap fromLeft baseGap colSpan totalCols = do
  let
    totalGaps = totalCols - 1
    gap = (1 / fromIntegral totalCols) * fromIntegral baseGap
    widthLeft = 100 - gap * fromIntegral totalGaps
    columnWidth = widthLeft / fromIntegral totalCols
    spannedWidth = columnWidth * fromIntegral colSpan + gap * fromIntegral (colSpan - 1)
  columnRaw
  width (pct spannedWidth)
  if fromLeft
    then float floatLeft >> marginLeft (pct gap) >> firstChild & marginLeft (pct 0)
    else float floatRight >> marginRight (pct gap) >> firstChild & marginRight (pct 0)

columnLeftGrid :: Integer -> Integer -> Css
columnLeftGrid colSpan totalCols = do
  let rule = pack $ show totalCols ++ "n + 1"
  columnLeft colSpan totalCols
  nthChild rule & (marginLeft (pct 0) >> clear clearLeft)
