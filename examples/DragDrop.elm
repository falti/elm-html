module DragDrop where

import Html exposing (Html, Attribute, text, div, input)
import Html.Attributes exposing (..)
import Html.Events exposing (onDrag, onDragEnd, onDragEnter, onDragExit, onDragLeave, onDragOver, onDragStart, onDrop)
import String
import List.Extra exposing (interweave)


-- VIEW

view : DnD -> Html
view dnd =
  div []
    (messageSink dnd :: interweave draggebles droppables)


draggableText : String -> Html
draggableText label =
    div[ 
      draggable "true"
    , dragStyle
    , onDragStart actions.address (DragStart label)
    ][ text label ]

draggebles : List Html
draggebles = [draggableText "Drag1", draggableText "Drag2"]

droppables : List Html
droppables = [dropArea "Drag1", dropArea "Drag2"]

dropArea : String -> Html
dropArea label =
  div[ 
    dropzone "move"
  , dropStyle
  , onDragOver actions.address DragOver
  , onDrop actions.address (Drop label)
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

type DnD = None | DragStart String | DragLeave | DragEnter | DragEnd | Drop String | DragOver


main : Signal Html
main =
  Signal.map view actions.signal

actions : Signal.Mailbox DnD
actions =
  Signal.mailbox None
