module Todos.Commands exposing (..)


import Task
import Http
import Json.Decode as Decode exposing ((:=))
import Json.Encode as Encode


import Todos.Messages exposing (..)
import Todos.Models exposing (..)


-- COMMANDS

getTodos : Cmd Msg
getTodos =
  Http.get collectionDecoder fetchAllUrl
    |> Task.perform FetchAllFail FetchAllDone


addTodo : TodosModel -> Cmd Msg
addTodo model =
  addTodoTask model.current
    |> Task.perform AddTodoFail AddTodoSuccess

deleteCompleted : Cmd Msg
deleteCompleted =
  deleteCompletedTask
    |> Task.perform DeleteCompletedFail DeleteCompletedSuccess

updateTodo : TODO -> Cmd Msg
updateTodo todo =
  updateTodoTask todo
    |> Task.perform TodoUpdateFail TodoUpdateSuccess




-- Urls

fetchAllUrl : String
fetchAllUrl = "http://localhost:4000/todos?_sort=id&_order=DESC"

addTodoUrl : String
addTodoUrl = "http://localhost:4000/todos"

deleteCompletedUrl : String
deleteCompletedUrl = "http://localhost:4000/todos/completed"


-- Decoders

collectionDecoder : Decode.Decoder (List TODO)
collectionDecoder =
  Decode.list todoDecoder

int2Str : Decode.Decoder int -> Decode.Decoder String
int2Str d =
  Decode.customDecoder d (\a -> Ok (toString a))

todoDecoder : Decode.Decoder TODO
todoDecoder =
  Decode.object3 TODO
    ( "id" := Decode.int )
    ( "text" := Decode.oneOf [Decode.string, Decode.int |> int2Str] )
    ( "done" := Decode.bool )


-- Encoders

todoEncoded : TODO -> Encode.Value
todoEncoded todo =
  let
    list =
      [ ( "text", Encode.string todo.text )
      , ( "done", Encode.bool todo.done )
      ]
  in
    list
      |> Encode.object




-- Tasks

addTodoTask : String -> Task.Task Http.Error TODO
addTodoTask current =
  let
    body =
      todoEncoded {id = 0, text = current, done = False}
        |> Encode.encode 0
        |> Http.string

    config =
      { verb = "POST"
      , headers = [ ("Content-type", "application/json") ]
      , url = addTodoUrl
      , body = body
      }
  in
    Http.send Http.defaultSettings config
      |> Http.fromJson todoDecoder


deleteCompletedTask : Task.Task String String
deleteCompletedTask =
  let
    config =
      { verb = "DELETE"
      , headers = [ ("Content-type", "application/json") ]
      , url = deleteCompletedUrl
      , body = Http.empty
      }
  in
    -- TODO: make it in a way to show an error when it happens:
    Http.send Http.defaultSettings config
      |> Task.map (always "")
      |> Task.mapError toString


updateTodoTask : TODO -> Task.Task Http.Error TODO
updateTodoTask todo =
  let
    todo = { todo | done = not todo.done }
    body =
      todoEncoded todo
        |> Encode.encode 0
        |> Http.string

    config =
      { verb = "PUT"
      , headers = [ ("Content-type", "application/json") ]
      , url = "http://localhost:4000/todos/" ++ toString todo.id
      , body = body
      }
  in
    Http.send Http.defaultSettings config
      |> Http.fromJson todoDecoder
