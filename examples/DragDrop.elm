module DragDrop where

import Html exposing (Html, Attribute, text, div, input)
import Html.Attributes exposing (..)
import Html.Events exposing (onDrag, onDragEnd, onDragEnter, onDragExit, onDragLeave, onDragOver, onDragStart, onDrop)
import Json.Decode as Json exposing (andThen)
import String


-- VIEW

view : DnD -> Html
view dnd =
  div []
    [ messageSink dnd
    , draggableText
    , dropArea
    ]


draggableText : Html
draggableText =
    div[ 
      draggable "true"
    , dragStyle
    , onDragStart actions.address DragStart
   -- , onDragEnd actions.address DragEnd
    ][ text "Drag me" ]

dropArea : Html
dropArea =
  div[ 
    dropzone "move"
  , dropStyle
  , onDragOver actions.address DragOver
  --, onDragEnter actions.address DragEnter
  --, onDragLeave actions.address DragLeave
  , onDrop actions.address Drop
  ][]

dragStyle : Attribute
dragStyle =
  style 
  [ ("width" , "100px")
  , ("line-style", "dashed")
  , ("height" , "30px")
  , ("background", "darkgrey")
  ]


dropStyle : Attribute
dropStyle =
  style 
  [ ("width" , "200px")
  , ("height" , "200px")
  , ("background", "lightgrey")
  ]

messageSink : DnD -> Html
messageSink dnd =
  div [ myStyle ] [ text (toString dnd )]


myStyle : Attribute
myStyle =
  style
    [ ("width", "100%")
    , ("height", "40px")
    , ("padding", "10px 0")
    , ("font-size", "2em")
    , ("text-align", "center")
    ]


-- SIGNALS

type DnD = None | DragStart | DragLeave | DragEnter | DragEnd | Drop | DragOver


main : Signal Html
main =
  Signal.map view actions.signal

actions : Signal.Mailbox DnD
actions =
  Signal.mailbox None
