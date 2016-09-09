module App exposing (..)


import Html.App


import Messages exposing (..)
--import Commands exposing (..)
import View exposing (view)
import Models exposing (Model, initialModel)
import Update exposing (update)


import Todos.Commands exposing (getTodos)

-- MODEL

init : (Model, Cmd Msg)
init =
  (initialModel, Cmd.map TodosMsg Todos.Commands.getTodos)




-- MAIN

main : Program Never
main =
  Html.App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = (always Sub.none)
    }
