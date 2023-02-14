import qualified Data.Map as M
import Data.Maybe
import Data.Char
import Data.Bits
import Data.Word

type Gate = String

data Term = ConstantTerm Word16
          | GateTerm Gate

data Expression = ConstantExpression Word16
                | UnaryExpression (Word16 -> Word16) Term
                | BinaryExpression (Word16 -> Word16 -> Word16) Term Term

type Circuit = M.Map Gate Expression

main = do
    input <- lines <$> readFile "../data/day07"
    let circuit = M.fromList $ map parseWiring input
    print $ partOne circuit         {- 956 -}
    print $ partTwo circuit         {- 40149-}

partOne :: Circuit -> Word16
partOne circ = snd $ evalGate circ "a" 

partTwo :: Circuit -> Word16
partTwo circ = let circ' = M.insert "b" (ConstantExpression 956) circ in snd $ evalGate circ' "a"

evalGate :: Circuit -> Gate -> (Circuit, Word16)
evalGate circ gate =
    case M.lookup gate circ of
        Just (ConstantExpression c) -> (circ, c)
        Just (UnaryExpression op a) -> let (circ', x) = evalTerm circ a in (circ', op x)
        Just (BinaryExpression op a b) -> 
            let (circ', x) = evalTerm circ a in 
            let (circ'', y) = evalTerm circ' b in (circ'', op x y)

evalTerm :: Circuit -> Term -> (Circuit, Word16)
evalTerm circ (ConstantTerm t) = (circ, t)
evalTerm circ (GateTerm a) = let (circ', val) = evalGate circ a in (M.insert a (ConstantExpression val) circ', val)

parseWiring :: String -> (Gate, Expression)
parseWiring s = let w = words s in (last w, parseExpression w)

parseTerm :: String -> Term
parseTerm t
  | all isDigit t = ConstantTerm $ read t
  | otherwise = GateTerm t

parseExpression :: [String] -> Expression
parseExpression [a, "->", _] = UnaryExpression id $ parseTerm a
parseExpression ["NOT", a, "->", _] = UnaryExpression complement $ parseTerm a
parseExpression [a, "AND", b, "->", _] = BinaryExpression (.&.) (parseTerm a) (parseTerm b)
parseExpression [a, "OR", b, "->", _] = BinaryExpression (.|.) (parseTerm a) (parseTerm b)
parseExpression [a, "LSHIFT", i, "->", _] = BinaryExpression (fromIntegerToWord16 shiftL) (parseTerm a) (parseTerm i)
parseExpression [a, "RSHIFT", i, "->", _] = BinaryExpression (fromIntegerToWord16 shiftR) (parseTerm a) (parseTerm i)

fromIntegerToWord16 :: (Word16 -> Int -> Word16) -> (Word16 -> Word16 -> Word16)
fromIntegerToWord16 f a b = f a $ fromIntegral b
