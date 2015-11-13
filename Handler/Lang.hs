module Handler.Lang where

import Import
import Text.Shakespeare.I18n

postLangR :: Handler Html
postLangR = do
  lang <- runInputPost $ ireq textField "lang"
  setLanguage lang
  defaultLayout $(widgetFile "blog")
