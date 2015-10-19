module Style.Variables where

import Style.Util.Import
import Clay (Size, Abs, px)
import Clay.Color

-- Colors
grayish' :: Float -> Color
grayish' val = grayish $ unormalize val 255

colorPitchBlack :: Color
colorPitchBlack = grayish' 0.150

colorBlack :: Color
colorBlack = grayish' 0.300

colorDarkGray :: Color
colorDarkGray = grayish' 0.450

colorGray :: Color
colorGray = grayish' 0.600

colorLightGray :: Color
colorLightGray = grayish' 0.850

colorWhite :: Color
colorWhite = grayish' 0.975

-- Media Queries Breakpoints
breakSm, breakMd, breakLg, breakXl :: Size Abs
breakSm', breakMd', breakLg', breakXl' :: Size Abs
breakSm = px 480
breakSm' = px 479
breakMd = px 768
breakMd' = px 767
breakLg = px 1024
breakLg' = px 1023
breakXl = px 1280
breakXl' = px 1279
