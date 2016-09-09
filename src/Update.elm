module Update exposing (..)


import Messages exposing (..)
import Models exposing (..)


import Todos.Update


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    TodosMsg subMsg ->
      let
        (updatedTodos, cmd) =
          Todos.Update.update subMsg model.todos
      in
        ( { model | todos = updatedTodos }, Cmd.map TodosMsg cmd )
