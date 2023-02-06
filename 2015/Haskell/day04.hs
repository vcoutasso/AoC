-- From MissingH 
import Data.Hash.MD5

main :: IO ()
main = do
        print partOne           {- 282749 -}
        print partTwo           {- 9962624 -}

partOne :: Int
partOne = firstMatch 5

partTwo :: Int
partTwo = firstMatch 6

firstMatch :: Int -> Int
firstMatch n = head xs 
        where (_, xs) = break (isHashValid n . hash) [1..]

hash :: Int -> String
hash = md5s . Str . ("yzbqklnj" ++) . show

isHashValid :: Int -> String -> Bool
isHashValid n str = replicate n '0' == take n str
