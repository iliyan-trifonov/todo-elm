module Models exposing (Model, initialModel)


import Todos.Models exposing (TODO, TodosModel)


type alias Model =
  { todos : TodosModel
  }

initialModel : Model
initialModel =
  { todos = Todos.Models.initialModel
  }
