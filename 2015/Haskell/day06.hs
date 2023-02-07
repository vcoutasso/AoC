import Control.Applicative
import Data.List

type Grid = [[Int]]
type Indices = ([Int], [Int])
type Coordinate = (Int, Int)

data Action = On | Off | Toggle deriving (Show, Eq, Enum)
data Instruction = Instruction { action :: Action, start :: Coordinate, end :: Coordinate } deriving (Show)

main :: IO ()
main = do
    instructions <- map getInstruction . lines <$> readFile "../data/day06"
    print $ partOne instructions        {- 400410 -}
    print $ partTwo instructions        {- 15343601 -}
    
-- Part one

partOne :: [Instruction] -> Int
partOne = sum . map sum . foldl partOneInstruction (newGrid 1000)

partOneInstruction :: Grid -> Instruction -> Grid
partOneInstruction grid instruction = case action' of
  On -> setGridAt indices' 1 grid
  Off -> setGridAt indices' 0 grid
  Toggle -> toggleGridAt indices' grid
  where (action', start', end') = liftA3 (,,) action start end instruction
        indices' = (indices start', indices end')

-- Part two

partTwo :: [Instruction] -> Int
partTwo = sum . map sum . foldl partTwoInstruction (newGrid 1000)

partTwoInstruction :: Grid -> Instruction -> Grid
partTwoInstruction grid instruction = case action' of
  On -> setGridAtWith indices' (+1) grid
  Off -> setGridAtWith indices' (+(-1)) grid
  Toggle -> setGridAtWith indices' (+2) grid
  where (action', start', end') = liftA3 (,,) action start end instruction
        indices' = (indices start', indices end')

setGridAtWith :: Indices -> (Int -> Int) -> Grid -> Grid
setGridAtWith (rows, cols) f = map (\(row, idx) -> if idx `elem` rows then setListAtWith cols f row else row) . enumerate

setListAtWith :: [Int] -> (Int -> Int) -> [Int] -> [Int]
setListAtWith indices f = map (\(x, idx) -> if idx `elem` indices then max 0 (f x) else x) . enumerate

-- Misc
  
toggleGridAt :: Indices -> Grid -> Grid
toggleGridAt (rows, cols) = map (\(row, idx) -> if idx `elem` rows then toggleListAt cols row else row) . enumerate

toggleListAt :: [Int] -> [Int] -> [Int]
toggleListAt indices = map (\(x, idx) -> if idx `elem` indices then toggleInt x else x) . enumerate

setGridAt :: Indices -> Int -> Grid -> Grid
setGridAt (rows, cols) value = map (\(row, idx) -> if idx `elem` rows then setListAt cols value row else row) . enumerate

setListAt :: [Int] -> Int -> [Int] -> [Int]
setListAt indices value = map (\(x, idx) -> if idx `elem` indices then value else x) . enumerate

newGrid :: Int -> Grid
newGrid n = replicate n (replicate n 0)

enumerate :: [a] -> [(a, Int)]
enumerate l = zip l (iota $ length l)

indices :: Coordinate -> [Int]
indices coord = drop (fst coord) . iota $ snd coord + 1

iota :: Int -> [Int]
iota n 
  | n < 0 = []
  | otherwise = [0..n-1]

toggleInt :: Int -> Int
toggleInt x = if x == 0 then 1 else 0

-- Parsing data

getInstruction :: String -> Instruction
getInstruction str = Instruction { action, start, end }
    where action = getAction str
          coordinates = getCoordinates str
          start = head coordinates
          end = last coordinates

getAction :: String -> Action
getAction instruction
  | "on" `elem` instructionWords = On
  | "off" `elem` instructionWords = Off
  | otherwise = Toggle
  where instructionWords = words instruction

getCoordinates :: String -> [Coordinate]
getCoordinates str = [(x1, y1), (x2, y2)] 
    where sep = ','
          [(x1, x2), (y1, y2)] = map (tuplify . map read . words' sep) . filter (sep `elem`) $ words str

words' :: Char -> String -> [String]
words' sep = words . map (\c -> if c == sep then ' ' else c)

tuplify :: [a] -> (a, a)
tuplify [x, y] = (x, y)
