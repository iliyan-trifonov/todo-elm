module Todos.Update exposing (..)


import Todos.Messages exposing (..)
import Todos.Models exposing (..)
import Todos.Commands exposing (..)


update : Msg -> TodosModel -> (TodosModel, Cmd Msg)
update msg model =
  case msg of
    FetchAllFail error ->
      ( { model | error = toString error }, Cmd.none )

    FetchAllDone todos ->
      ( {model | todos = todos, error = ""}, Cmd.none )

    AddTodo ->
      if model.current /= "" then
        ( { model | error = "" }, addTodo model )
      else
        ( { model | error = "Empty TODO text" }, Cmd.none )

    AddTodoFail error ->
      -- TODO: ..Task.mapError toString.. and remove the toString here
      ( { model | error = toString error }, Cmd.none )

    AddTodoSuccess todo ->
      ( { model | current = "" }, getTodos )

    ChangeCurrent txt ->
      ( { model | current = txt }, Cmd.none )

    DeleteCompleted ->
      ( model, deleteCompleted )

    DeleteCompletedFail error ->
      ( { model | error = error }, Cmd.none )

    DeleteCompletedSuccess _ ->
      ( model, getTodos )

    ToggleChecked todo _ ->
      ( model, updateTodo todo )

    TodoUpdateFail error ->
      ( { model | error = toString error }, Cmd.none )

    TodoUpdateSuccess _ ->
      ( model, getTodos )

    KeyDown keyCode ->
      if keyCode == 13 then
        update AddTodo model
      else
        ( model, Cmd.none )
