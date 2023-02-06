import qualified Data.Map as Map
import Data.List

main :: IO ()
main = do
        input <- readFile "../data/day05"
        let strings = lines input
        print $ partOne strings                 {- 238 -}
        print $ partTwo strings                 {- 69 -}

-- Part one

partOne :: [String] -> Int
partOne = sum . map (boolToInt . partOneCriteria)

partOneCriteria :: String -> Bool
partOneCriteria s = atLeastThreeVowels s && atLeastOneTwiceInARow s && noForbiddenStrings s

atLeastThreeVowels :: String -> Bool
atLeastThreeVowels = (3 <=) . length . filter isVowel

atLeastOneTwiceInARow :: String -> Bool
atLeastOneTwiceInARow s = or . zipWith (==) s $ tail s

noForbiddenStrings :: String -> Bool
noForbiddenStrings s
  | length s < 2 = True
  | (x:y:_) <- s = [x, y] `notElem` ["ab", "cd", "pq", "xy"] && noForbiddenStrings (tail s)

isVowel :: Char -> Bool
isVowel = (`elem` "aeiou")

-- Part two

partTwo :: [String] -> Int
partTwo = sum . map (boolToInt . partTwoCriteria)

partTwoCriteria :: String -> Bool
partTwoCriteria s = repeatsWithOneInBetween s && nonOverlappingPairs s

repeatsWithOneInBetween :: String -> Bool
repeatsWithOneInBetween s 
  | length s < 3 = False
  | (x:_:y:_) <- s = x == y || repeatsWithOneInBetween (tail s)

nonOverlappingPairs :: String -> Bool
nonOverlappingPairs s = (any  (any (> 1) . diffWithFirst . (`elemIndices` adjacentPairs s)) . Map.keys) $ repeatingPairs s

adjacentPairs :: String -> [String]
adjacentPairs s = zipWith (\x y -> [x,y]) s $ tail s

repeatingPairs :: String -> Map.Map String Int
repeatingPairs s = Map.filter (> 1) . Map.fromListWith (+) . map (, 1) $ adjacentPairs s

diffWithFirst :: [Int] -> [Int]
diffWithFirst xs = tail $ scanl1 (\_ x -> x - head xs) xs

-- Misc

boolToInt :: Bool -> Int
boolToInt x = if x then 1 else 0
