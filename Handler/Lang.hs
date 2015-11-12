module Handler.Lang where

import Import

getLangEnR :: Handler Html
getLangEnR = do
  setLanguage "en"
  redirect HomeR

getLangEsR :: Handler Html
getLangEsR = do
  setLanguage "es"
  redirect HomeR
