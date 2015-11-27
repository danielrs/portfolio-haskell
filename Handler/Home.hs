module Handler.Home where

import Import
import Mail.Hailgun
import Text.Shakespeare.I18n
import Yesod.Hailgun
import Text.Hamlet (shamletFile)

-- This is a handler function for the GET request method on the HomeR
-- resource pattern. All of your resource patterns are defined in
-- config/routes
--
-- The majority of the code you will write in Yesod lives in these handler
-- functions. You can spread them across multiple files if you are so
-- inclined, or create a single monolithic file.

-- Data type for contact form
data Contact = Contact
  { name :: Text
  , email :: Text
  , title :: Text
  , content :: Textarea }

contactForm :: Form Contact
contactForm extra = do
  render <- getMessageRender
  let
    set label placeholder = FieldSettings label Nothing Nothing Nothing [("placeholder", placeholder)]
  (nameRes, nameView) <- mreq textField (set "name" (render MsgContactName)) Nothing
  (emailRes, emailView) <- mreq emailField (set "email" (render MsgContactEmail)) Nothing
  (titleRes, titleView) <- mreq textField (set "title" (render MsgContactTitle)) Nothing
  (msgRes, msgView) <- mreq textareaField (set "msg" (render MsgContactContent)) Nothing

  let contactRes = Contact <$> nameRes <*> emailRes <*> titleRes <*> msgRes
  let widget = do
      [whamlet|
        #{extra}
        ^{fvInput nameView}
        ^{fvInput emailView}
        ^{fvInput titleView}
        ^{fvInput msgView}
        <input type=submit value=_{MsgContactSend}>
      |]

  return (contactRes, widget)

allHomeR :: Widget -> Enctype -> Handler Html
allHomeR contactWidget enctype = do
  defaultLayout $ do
    setTitle $ "Daniel Rivas - Home"
    $(whamletFilei18n "templates/homepage" ["en", "es"] ".hamlet")

getHomeR :: Handler Html
getHomeR = do
    (contactWidget, enctype) <- generateFormPost contactForm
    allHomeR contactWidget enctype

postHomeR :: Handler Html
postHomeR = do
  ((result, contactWidget), enctype) <- runFormPost contactForm
  render <- (toHtml .) <$>  getMessageRender
  langs <- languages
  $logInfo "Email POST request received"
  case result of
    FormSuccess contact -> do
      sendTo <- appEmail . appSettings <$> getYesod
      sendRes <- sendHtmlMail
        (title contact)
        ($(shamletFilei18n "templates/email/contact" ["en", "es"] ".hamlet") langs)
        (email contact)
        [sendTo]
      case sendRes of
        Left err -> do
          setMessage $ render MsgMailServerError
          $logError $ "Mailgun error - " ++ (pack . herMessage $ err)
          redirect HomeR
        Right _ -> do
          setMessage $ render MsgMailSent
          $logInfo "Email sent correctly!"
          redirect HomeR
    _ -> do
      setMessage $ render MsgMailError
      $logWarn "Form validation error"
      allHomeR contactWidget enctype
