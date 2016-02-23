module Form where
import String
import Html exposing (..)
import Html.Attributes exposing (value, type', rel, href, class)
import Html.Events exposing (on, targetValue)
import Input

-- Model

type alias Model =
  {
    firstName : String
  , lastName : String
  , password : String
  , passwordRepeat: String
  }

init : String -> String -> String -> String -> Model

init firstName lastName password passwordRepeat =
  {
    firstName = firstName
  , lastName = lastName
  , password = password
  , passwordRepeat = passwordRepeat
  }

-- Update

type Action =
    UpdateFirstName String
  | UpdateLastName String
  | UpdatePassword String
  | UpdatePasswordRepeat String

update : Action -> Model -> Model

update action model =
  case action of
    UpdateFirstName val ->
      { model |
        firstName = val
      }

    UpdateLastName val ->
      { model |
        lastName = val
      }

    UpdatePassword val ->
      { model |
        password = val
      }

    UpdatePasswordRepeat val ->
      { model |
        passwordRepeat = val
      }

-- View

arePasswordsEqual : String -> String -> String

arePasswordsEqual password passwordRepeat =
  if password == passwordRepeat then
    "Passwords are equal"
  else
    "Passwords are NOT EQUAL"

inputDefaultSchema = Input.defaultSchema

schema =
  {
    firstName =
      { inputDefaultSchema |
        maxValue = 3
      , maxErrMsg = "First name cannot exceed 3 characters"
      , minValue = 1
      , minErrMsg = "First name must be at least 1 characters"
      }
  , lastName = inputDefaultSchema
  , password = inputDefaultSchema
  , passwordRepeat = inputDefaultSchema
  }

view : Signal.Address Action -> Model -> Html
view address model =
  section [ class "form-container" ]
  [
    form [] [
      Input.view
      {
        inputType = Input.Text
      , value = model.firstName
      , schema = schema.firstName
      , placeholder = "First name"
      , onChange = (Signal.message address << UpdateFirstName)
      }
    , Input.view
      {
        inputType = Input.Text
      , value = model.lastName
      , schema = schema.lastName
      , placeholder = "Last name"
      , onChange = (Signal.message address << UpdateLastName)
      }
    , Input.view
      {
        inputType = Input.Password
      , value = model.password
      , schema = schema.password
      , placeholder = "Password"
      , onChange = (Signal.message address << UpdatePassword)
      }
    , Input.view
      {
        inputType = Input.Password
      , value = model.passwordRepeat
      , schema = schema.passwordRepeat
      , placeholder = "Repeat password"
      , onChange = (Signal.message address << UpdatePasswordRepeat)
      }
    ]
  , span [ class "passwords-equal" ]
    [
      text (arePasswordsEqual model.password model.passwordRepeat)
    ]
  ]