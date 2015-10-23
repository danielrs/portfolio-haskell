module Handler.Home where

import Import

-- This is a handler function for the GET request method on the HomeR
-- resource pattern. All of your resource patterns are defined in
-- config/routes
--
-- The majority of the code you will write in Yesod lives in these handler
-- functions. You can spread them across multiple files if you are so
-- inclined, or create a single monolithic file.

-- Data type for contact form
data Contact = Contact
  { sender :: Text
  , title :: Text
  , content :: Textarea }

contactForm :: Form Contact
contactForm extra = do
  let
    set label placeholder = FieldSettings label Nothing Nothing Nothing [("placeholder", placeholder)]
  (emailRes, emailView) <- mreq emailField (set "email" "Your email address") Nothing
  (titleRes, titleView) <- mreq textField (set "title" "Title") Nothing
  (msgRes, msgView) <- mreq textareaField (set "msg" "Tell me what you need!") Nothing

  let contactRes = Contact <$> emailRes <*> titleRes <*> msgRes
  let widget = do
      [whamlet|
        #{extra}
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
