module Input where

import String
import Html exposing (..)
import Html.Attributes exposing (class, type', value, placeholder)
import Html.Events exposing (targetValue, on)
import Array

-- view
type InputType
  = Text
  | Password

type alias Schema =
  {
    maxValue : Int
  , maxErrMsg : String
  , minValue : Int
  , minErrMsg : String
  }

defaultSchema : Schema

defaultSchema =
  {
    maxValue = 65535
  , maxErrMsg = "Value too long"
  , minValue = 0
  , minErrMsg = "Value too short"
  }

inputTypeToString : InputType -> String

inputTypeToString inputType =
  case inputType of
    Text -> "text"
    Password -> "password"

type alias Attrs =
  {
    inputType : InputType
  , value : String
  , placeholder: String
  , schema: Schema
  , onChange : String -> Signal.Message
  }

-- Emptynode helper
emptyNode : Html

emptyNode =
  text ""

-- Error msg


errorMsgs : String -> Schema -> List String
errorMsgs val schema =
  let
    maxError =
      if String.length val > schema.maxValue then
        schema.maxErrMsg
      else
        ""
    minError =
      if String.length val < schema.minValue then
        schema.minErrMsg
      else
        ""
  in
    List.filter (\item -> item /= "") (maxError :: minError :: [])

-- Main view

errMessages : List String -> List Html
errMessages errors = List.map (\err -> li [] [ text err ]) errors

view : Attrs -> Html

view attrs =
  let
    validationErrors = errorMsgs attrs.value attrs.schema
    hasErrors = List.length validationErrors > 0
    errorList =
      if hasErrors then
        div [ class "err-container" ]
        [
          ul [] (errMessages validationErrors)
        , div [ class "ticker" ] []
        ]
      else
        text ""
    className =
      if hasErrors then
        "input-field error"
      else
        "input-field"
  in
    div [ class "input-container" ] [
      errorList
    , input [
        type' (inputTypeToString attrs.inputType)
      , placeholder attrs.placeholder
      , class className
      , value attrs.value
      , on "input" targetValue (attrs.onChange)
      ] []
    ]