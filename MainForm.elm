import Form
import StartApp.Simple exposing (start)
import Html exposing (..)
import Html.Attributes exposing (value, type', rel, href)

-- Wrapper for css
css : String -> Html
css path =
  node "link" [ rel "stylesheet", href path ] []

mainView : Signal.Address Form.Action -> Form.Model -> Html

mainView address model =
  section []
  [
    css "mainForm.css"
  , Form.view address model
  ]


main =
  start
    { model = Form.init "Esko" "Pena" "sikapossu22" "sikapossu22"
    , update = Form.update
    , view = mainView
    }