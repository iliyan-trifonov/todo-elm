module View exposing (..)


import Html exposing(Html, div, input, label, text, li, button, ul, h1)
import Html.Attributes exposing (class, placeholder, checked, type', value, style)
import Html.Events exposing (onInput, onClick, onCheck)
import Html.App


import Messages exposing (..)
import Models exposing (..)


import Todos.Add
import Todos.List
import Todos.Completed



showError : String -> Html msg
showError error =
  div [ style [("color", "red"), ("margin", "10px 0")] ] [ text error ]

view : Model -> Html Msg
view model =
  div []
    [ h1 []
      [ text "TODO in Elm" ]
    , showError model.todos.error
    , Html.App.map TodosMsg ( Todos.Add.view model.todos.current )
    , div [class "todocontainer"]
        [ Html.App.map TodosMsg ( Todos.List.view model.todos.todos ) ]
    , Html.App.map TodosMsg ( Todos.Completed.view )
    ]
