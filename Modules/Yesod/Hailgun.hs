module Yesod.Hailgun (
  YesodHailgun(
    hailgunContext
    , sendMail
    , sendHtmlMail
  )
) where

import Yesod
import Mail.Hailgun
import Data.Text (Text)
import Data.Text.Encoding (encodeUtf8)
import Prelude
import Text.Blaze.Html.Renderer.Utf8 (renderHtml)
import Data.ByteString.Lazy (toStrict)

class (Yesod master) => YesodHailgun master where

  hailgunContext :: master ->  HailgunContext

  sendRawMail ::
    Text -- title
    -> MessageContent -- body
    -> Text -- sender
    -> [Text] -- recipients
    -> HandlerT master IO (Either HailgunErrorResponse HailgunSendResponse)
  sendRawMail title body sender recipients = do
    master <- getYesod
    let
      emessage = hailgunMessage
        title
        body
        (encodeUtf8 sender)
        (MessageRecipients (encodeUtf8 <$> recipients) [] [])
        []
    case emessage of
      Left errorMessage ->
        return $ Left $ HailgunErrorResponse errorMessage
      Right message -> do
        response <- liftIO $ sendEmail (hailgunContext master) message
        return response

  sendMail ::
    Text -- title
    -> Text -- body
    -> Text -- sender
    -> [Text] -- recipients
    -> HandlerT master IO (Either HailgunErrorResponse HailgunSendResponse)
  sendMail title body sender recipients =
    sendRawMail title (TextOnly $ encodeUtf8 body) sender recipients

  sendHtmlMail ::
    Text -- title
    -> Html -- body
    -> Text -- sender
    -> [Text] -- recipients
    -> HandlerT master IO (Either HailgunErrorResponse HailgunSendResponse)
  sendHtmlMail title bodyHtml sender recipients =
    sendRawMail title (TextAndHTML rendered rendered) sender recipients
    where rendered = toStrict . renderHtml $ bodyHtml
