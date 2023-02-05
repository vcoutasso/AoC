main = do
        input <- readFile "../data/day01"
        print $ partOne input         {- 74 -}
        print $ partTwo input         {- 1795 -}

partOne :: String -> Int
partOne = sum . map floorValue

partTwo :: String -> Int
partTwo = length . takeWhile (/= -1) . scanl (+) 0 . map floorValue

floorValue :: Char -> Int
floorValue f
        | f == '(' = 1
        | f == ')' = -1
        | otherwise = 0
