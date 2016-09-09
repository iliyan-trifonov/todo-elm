module Todos.Completed exposing (..)

import Html exposing(Html, div, input, label, text, li, button, ul, h1)
import Html.Attributes exposing (class, placeholder, checked, type', value, style)
import Html.Events exposing (onInput, onClick, onCheck)


import Todos.Messages exposing (..)



view : Html Msg
view =
  button [class "button", onClick DeleteCompleted] [text "Delete all completed"]
