module Handler.Budget where

import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3, withSmallInput)
import Text.Julius (RawJS (..))

getBudgetR :: Handler Html
getBudgetR = do
  (formWidget, formEnctype) <- generateFormPost sampleForm
  defaultLayout $ do
    setTitle "Welcome To The Budget!"
    $(widgetFile "budget")


postBudgetR :: Handler Html
postBudgetR = do
    ((result, formWidget), formEnctype) <- runFormPost sampleForm
    case result of
      FormSuccess res -> setMessage $ toHtml res
      _ -> setMessage "Failed"
    redirect BudgetR

sampleForm :: Form Text
sampleForm = renderBootstrap3 BootstrapBasicForm $ id
    <$> areq textField (withSmallInput "Some Text: ") Nothing
