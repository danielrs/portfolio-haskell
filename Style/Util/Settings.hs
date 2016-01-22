module Style.Util.Settings where

import Style.Util.Import
import Clay (Size, Abs, Time, px)
import Clay.Color
import Clay.Time (ms)

-- Transitions

speedFast :: Time
speedFast = ms 125

speedMedium :: Time
speedMedium = ms 250

speedSlow :: Time
speedSlow = ms 500

-- Colors
grayish' :: Double -> Color
grayish' val = grayish $ unormalize val 255

colorPrimary :: Color
colorPrimary = hexColor "#00aadd"

colorPitchBlack :: Color
colorPitchBlack = grayish' 0.275

colorBlack :: Color
colorBlack = grayish' 0.400

colorDarkGray :: Color
colorDarkGray = grayish' 0.525

colorGray :: Color
colorGray = grayish' 0.650

colorLightGray :: Color
colorLightGray = grayish' 0.850

colorWhite :: Color
colorWhite = grayish' 0.990

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
