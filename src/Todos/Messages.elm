module Todos.Messages exposing (..)

import Http
import Keyboard
import Todos.Models exposing (..)

type Msg
  = FetchAllFail Http.Error
  | FetchAllDone (List TODO)
  | ChangeCurrent String
  | AddTodo
  | AddTodoFail Http.Error
  | AddTodoSuccess TODO
  | DeleteCompleted
  | DeleteCompletedFail String
  | DeleteCompletedSuccess String
  | ToggleChecked TODO Bool
  | TodoUpdateFail Http.Error
  | TodoUpdateSuccess TODO
  | KeyDown Keyboard.KeyCode
