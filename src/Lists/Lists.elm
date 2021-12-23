module Lists exposing (..)
import List
import Maybe

lastElement : List a -> Maybe a
lastElement list =
  case list of
    [h] -> Just h
    [] -> Nothing
    h :: t -> lastElement t

penultimate : List a -> Maybe a
penultimate list =
  case list of
    [] -> Nothing
    x::xs::[] -> Just x
    _::xs -> penultimate xs

nth : Int -> List a -> Maybe a
nth index list =
  let
    rec l acc =
      case l of
        x::xs -> if acc == index then Just x else rec xs (acc + 1)
        [] -> Nothing
  in
    rec list 0

myLength : List a -> Int
myLength = List.foldl (\_ acc -> acc + 1) 0

myReverse : List a -> List a
myReverse = List.foldl (::) []

isPalindrome : List a -> Bool
isPalindrome list =
  list == myReverse list

type NestedList a
    = Elem a
    | NestedList (List (NestedList a))

flatten : NestedList a -> List a
flatten nestedList =
  case nestedList of
    Elem x -> [x]
    NestedList [] -> []
    NestedList (x :: xs) -> flatten x ++ flatten (NestedList xs)
    -- to complex
    -- NestedList (NestedList x :: xs) -> (List.concatMap flatten x) ++ (List.concatMap flatten xs)
    -- NestedList (Elem x :: xs) -> x :: List.concatMap flatten xs

compress : List a -> List a
compress list =
  -- to complex
  -- let
  --   helper prev l = case l of
  --     [] -> []
  --     [x] -> if x /= prev then l else []
  --     x :: xs -> if x /= prev then l else helper prev xs
  -- in
  --   case list of
  --     [] -> []
  --     [_] -> list
  --     x :: xs ->
  --       let newList = helper x xs in x :: compress newList
  case list of
    [] -> []
    [_] -> list
    x1 :: x2 :: xs ->
      if (x1 == x2) then
        compress (x2 :: xs)
      else
        x1 :: compress (x2 :: xs)

pack : List a -> List (List a)
pack list =
  case list of
    [] -> []
    [x] -> [[x]]
    x :: xs ->
      let
        subList = List.foldl (\elem acc -> if elem == x then x :: acc else acc) [] xs
        filteredList = List.filter (\elem -> elem /= x) xs
      in [x :: subList] ++ pack filteredList

runLengthEncode : List a -> List (a, Int)
runLengthEncode list =
  case list of
    [] -> []
    [x] -> [(x, 1)]
    x :: xs -> case runLengthEncode xs of
      [] -> []
      (xp, count) :: xsp ->
        if xp == x then
          (xp, count + 1) :: xsp
        else
          (x, 1) :: (xp, count) :: xsp
