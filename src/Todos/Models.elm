module Todos.Models exposing (..)



type alias TODO =
  { id: Int
  , text : String
  , done : Bool
  }

type alias TodosModel =
  { current : String
  , todos : List TODO
  , error : String
  }


initialModel : TodosModel
initialModel =
  { current = ""
  , todos = []
  , error = ""
  }
