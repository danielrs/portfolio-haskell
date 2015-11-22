module Yesod.Hailgun where

import Yesod
import Mail.Hailgun
import Data.Text (Text)
import Data.Text.Encoding (encodeUtf8)
import Prelude

class (Yesod master) => YesodHailgun master where

  hailgunContext :: master ->  HailgunContext

  sendMail ::
    Text -- title
    -> Text -- body
    -> Text -- sender
    -> [Text] -- recipients
    -> HandlerT master IO (Either HailgunErrorResponse HailgunSendResponse)
  sendMail title body sender recipients = do
    master <- getYesod
    let
      emessage = hailgunMessage
        title
        (TextOnly $ encodeUtf8 body)
        (encodeUtf8 sender)
        (MessageRecipients (encodeUtf8 <$> recipients) [] [])
        []
    case emessage of
      Left errorMessage ->
        return $ Left $ HailgunErrorResponse errorMessage
      Right message -> do
        response <- liftIO $ sendEmail (hailgunContext master) message
        return response
