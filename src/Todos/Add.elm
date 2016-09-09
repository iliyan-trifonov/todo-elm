module Todos.Add exposing (..)

import Html exposing(Html, div, input, label, text, li, button, ul, h1)
import Html.Attributes exposing (class, placeholder, checked, type', value, style)
import Html.Events exposing (onInput, onClick, onCheck)
import Json.Decode as Decode exposing ((:=))


import Todos.Messages exposing (..)



view : String -> Html Msg
view current =
  div []
    [ input [type' "text", placeholder "Add a TODO here", value current, onInput ChangeCurrent, Html.Events.on "keydown" (Decode.map KeyDown Html.Events.keyCode) ] []
    , button [class "button", onClick AddTodo] [text "Add TODO"]
    ]
