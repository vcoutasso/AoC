import Data.List
import Data.Function

main = do
        input <- readFile "../data/day03"
        let directions = getDirections input
        print $ partOne directions              {- 2572 -}
        print $ partTwo directions              {- 2631 -}

partOne :: [(Int, Int)] -> Int
partOne = countUniques . deliveries

partTwo :: [(Int, Int)] -> Int
partTwo d = countUniques $ ((++) `on` deliveries) evens odds
        where (evens, odds) = splitEvenOdd d

countUniques :: (Eq a) => [a] -> Int
countUniques = length . nub

getDirections :: String -> [(Int, Int)]
getDirections = map direction . head . lines

direction :: Char -> (Int, Int)
direction c
        | c == '>' = (1, 0)
        | c == '<' = (-1, 0)
        | c == '^' = (0, 1)
        | c == 'v' = (0, -1)

deliverPresent :: (Int, Int) -> (Int, Int) -> (Int, Int)
deliverPresent (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

deliveries :: [(Int, Int)] -> [(Int, Int)]
deliveries = scanl deliverPresent (0, 0)

splitEvenOdd :: [a] -> ([a], [a])
splitEvenOdd [] = ([], [])
splitEvenOdd (x:xs) = (x:odds, evens)
        where (evens, odds) = splitEvenOdd xs
