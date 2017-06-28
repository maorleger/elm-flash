module Flash
    exposing
        ( State
        , setFlash
        , none
        , getMessage
        )

{-|
A Flash module

This module provides a mechanism for controlling the events around showing and hiding a flash message.

# Types
@docs State

# Initializing an empty flash message
@docs none

# Getting the flash message out
@docs getMessage

# Setting the flash and timer
@docs setFlash

-}

import Process
import Task
import Time exposing (Time)


{-| The State type
-}
type State
    = State (Maybe String)


{-| An empty State, no flash message
-}
none : State
none =
    State Nothing


{-| Getting the flash message out of the state container
-}
getMessage : State -> Maybe String
getMessage (State message) =
    message


{-| Initializing the timer with a flash message
-}
setFlash : msg -> Time -> String -> ( State, Cmd msg )
setFlash msg timeout flashMessage =
    ( State (Just flashMessage), Task.perform (always msg) (Process.sleep timeout) )
