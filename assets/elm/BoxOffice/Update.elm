module BoxOffice.Update exposing (..)

import BoxOffice.Messages exposing (..)
import Model exposing (..)
import DataModel exposing (RemoteData(..))
import List.Extra as ListExtra


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        FetchScreenings (Ok response) ->
            let
                oldBoxOffice =
                    model.boxOffice

                updatedBoxOffice =
                    { oldBoxOffice | availableScreenings = Success response }
            in
                { model | boxOffice = updatedBoxOffice } ! []

        FetchScreenings (Err error) ->
            let
                oldBoxOffice =
                    model.boxOffice

                newBoxOffice =
                    { oldBoxOffice | availableScreenings = Failure "Something went wrong" }
            in
                { model | boxOffice = newBoxOffice } ! []

        ScreeningChanged value ->
            case model.boxOffice.availableScreenings of
                Success screeningList ->
                    let
                        oldBoxOffice =
                            model.boxOffice

                        screeningId =
                            Result.withDefault 0 (String.toInt value)

                        selectedScreening =
                            ListExtra.find (\screening -> screening.id == screeningId) screeningList

                        newBoxOffice =
                            { oldBoxOffice | selectedScreening = selectedScreening }
                    in
                        { model | boxOffice = newBoxOffice } ! []

                _ ->
                    model ! []
