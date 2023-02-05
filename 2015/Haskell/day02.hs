import Data.List

main = do
        input <- readFile "../data/day02"
        print . partOne $ parseInput input      {- 1588178 -}
        print . partTwo $ parseInput input      {- 3783758 -}

-- Part one solution

partOne :: [[Int]] -> Int
partOne = sum . map (paperLength . facesArea)

paperLength :: [Int] -> Int
paperLength faces = minimum faces + sum (map (* 2) faces)
        
facesArea :: [Int] -> [Int]
facesArea = map product . filter ((== 2) . length) . subsequences

-- Part two solution

partTwo :: [[Int]] -> Int
partTwo x = sum $ zipWith (+) (bowRibbon x) (wrapRibbon x)

wrapRibbon :: [[Int]] -> [Int]
wrapRibbon = map ((* 2) . sum . take 2 . sort)

bowRibbon :: [[Int]] -> [Int]
bowRibbon = map product


-- Input parsing

parseInput :: String -> [[Int]]
parseInput = map (map readInt . words . wordify 'x') . lines

readInt :: String -> Int
readInt = read

wordify :: Char -> String -> String
wordify sep = map (\c -> if c == sep then ' ' else c)
