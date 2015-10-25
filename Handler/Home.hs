module Handler.Home where

import Import
import Mail.Hailgun

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

getHomeR :: Handler Html
getHomeR = do
    (contactWidget, enctype) <- generateFormPost contactForm
    defaultLayout $ do
        setTitle "Daniel Rivas - Home"
        $(widgetFile "homepage")

postHomeR :: Handler Html
postHomeR = do
  ((result, contactWidget), enctype) <- runFormPost contactForm
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
          setMessage "There was an unknown error sending your email"
          redirect HomeR
        Right _ -> do
          setMessage "Your email has been sent!"
          redirect HomeR

    _ -> defaultLayout $ do
      setMessage "There was an error sending your email"
      setTitle "Daniel Rivas - Home"
      $(widgetFile "homepage")
