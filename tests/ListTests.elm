module ListTests exposing (..)

import Expect exposing (..)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import List
import Lists
import Maybe


listSuite : Test
listSuite =
  describe "List Tests 1"
    [ describe "lastElement"
        [ test "empty list should return nothing" <|
            \_ ->
              case Lists.lastElement [] of
                Nothing -> Expect.pass
                _ -> Expect.fail "should be Nothing"
        , test "should return Just 5" <|
          \_ ->
            let list = [1,2,3,4,5] in
              case Lists.lastElement list of
                Just 5 -> Expect.pass
                _ -> Expect.fail "should be Just 5"
        ]
    , describe "penultimate"
        [ test "empty list should return nothing" <|
            \_ ->
              case Lists.penultimate [] of
                Nothing -> Expect.pass
                _ -> Expect.fail "should be Nothing"
        , test "should return Just 4" <|
            \_ ->
              let list = [1,2,3,4,5] in
                case Lists.penultimate list of
                  Just 4 -> Expect.pass
                  _ -> Expect.fail "should be Just 4"
        ]
    , describe "nth"
        [ fuzz int "empty lists should always return nothing" <|
            \fuzzInt ->
              case Lists.nth fuzzInt [] of
                Nothing -> Expect.pass
                _ -> Expect.fail "should be nothing"
        , test "should return Just 7" <|
            \_ ->
              let list = [1,2,3,4,5,6,7,8] in
                case Lists.nth 6 list of
                  Just 7 -> Expect.pass
                  _ -> Expect.fail "should be Just 7"
        ]
    , describe "myLength"
        [ fuzz (list int) "should return correct list length" <|
            \fuzzList ->
              let
                myLength = List.length fuzzList
                myLength2 = Lists.myLength fuzzList
              in
                Expect.equal myLength myLength2
        ]
    ]
