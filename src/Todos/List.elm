module Todos.List exposing (..)


import Html exposing(Html, div, input, label, text, li, button, ul, h1)
import Html.Attributes exposing (class, placeholder, checked, type', value, style)
import Html.Events exposing (onInput, onClick, onCheck)
import Json.Decode as Decode exposing ((:=))


import Todos.Messages exposing (..)
import Todos.Models exposing (..)



view : List TODO -> Html Msg
view todos =
    div []
    [ listTodos todos
    ]

listTodos : List TODO -> Html Msg
listTodos list =
  ul [class "todolist"] (List.map todoRow list)

todoRow : TODO -> Html Msg
todoRow todo =
  li []
    [ label []
      [ input [type' "checkbox", checked todo.done, onCheck (ToggleChecked todo)] [ ]
      , text todo.text
      ]
    ]
