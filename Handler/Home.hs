module Handler.Home where

import Import
import Mail.Hailgun
import Text.Shakespeare.I18L

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
  let
    set label placeholder = FieldSettings label Nothing Nothing Nothing [("placeholder", placeholder)]
  (nameRes, nameView) <- mreq textField (set "name" "Your name") Nothing
  (emailRes, emailView) <- mreq emailField (set "email" "Your email address") Nothing
  (titleRes, titleView) <- mreq textField (set "title" "Title") Nothing
  (msgRes, msgView) <- mreq textareaField (set "msg" "Tell me what you need!") Nothing

  let contactRes = Contact <$> nameRes <*> emailRes <*> titleRes <*> msgRes
  let widget = do
      [whamlet|
        #{extra}
        ^{fvInput nameView}
        ^{fvInput emailView}
        ^{fvInput titleView}
        ^{fvInput msgView}
        <input type=submit value=Send>
      |]

  return (contactRes, widget)

allHomeR :: Widget -> Enctype -> Handler Html
allHomeR contactWidget enctype = do
  defaultLayout $ do
    setTitle $ "Daniel Rivas - Home"
    -- $(whamletFilei18L "templates/homepage" ["en", "es"])
    $(whamletFile "templates/homepage-en.hamlet")

getHomeR :: Handler Html
getHomeR = do
    (contactWidget, enctype) <- generateFormPost contactForm
    allHomeR contactWidget enctype

postHomeR :: Handler Html
postHomeR = do
  ((result, contactWidget), enctype) <- runFormPost contactForm
  $logInfo "Email POST request received"
  case result of
    FormSuccess contact -> do
      settings <- appSettings <$> getYesod
      let
        context = HailgunContext
          (appMailDomain settings)
          (appMailApiKey settings)
          Nothing
        Right message = hailgunMessage
          (title contact)
          (TextOnly $ encodeUtf8 . unTextarea . content $ contact)
          (encodeUtf8 . email $ contact)
          (MessageRecipients [encodeUtf8 . appMailSendTo $ settings] [] [])
          []

      sendRes <- liftIO $ sendEmail context message
      case sendRes of
        Left err -> do
          setMessage "There was a server error sending your email"
          $logError $ "Mailgun error - " ++ (pack . herMessage $ err)
          redirect HomeR
        Right _ -> do
          setMessage "Your email has been sent!"
          $logInfo "Email sent correctly!"
          redirect HomeR

    _ -> do
      setMessage "There was an error validating the contact form"
      $logWarn "Form validation error"
      allHomeR contactWidget enctype
