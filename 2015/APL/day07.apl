⍝ This solution was heavily inspired by Stefan Kruger's (xpqz on GitHub) to whom I owe a huge thanks

data ← ⊃⎕NGET'../data/day07'1

⍝ Utilities
decToBin  ← (16⍴2)⊤⊢							⍝ Converts from decimal to binary
binToDec  ← 2⊥⊢								⍝ Converts from binary to decimal
parseInst ← {tokens←' '(≠⊆⊢)⍵ ⋄ (⊃¯1↑tokens)(,' ',⍨↑¯2↓tokens)}		⍝ Parse instruction into an executable APL expression
split	  ← ⊣(≠⊆⊢)⊢							⍝ Splits the array at specifier (left arg)
lookupDict← {¯1=⍺⍺.v:⍺⍺.v⊣⍺⍺.v←⍵⍵ ⍵ ⋄ ⍺⍺.v}				⍝ Expects a namespace as the left argument with ¯1 for non evaluated expressions, and a expression to be evaluated as the right argument

⍝ Logic functions as defined in the problem statement
AND	← binToDec (decToBin ⊣) ∧ (decToBin ⊢)
OR	← binToDec (decToBin ⊣) ∨ (decToBin ⊢)
NOT	← binToDec (~decToBin)
RSHIFT	← binToDec ⊢↓(-⊢)⌽ (decToBin ⊣)
LSHIFT	← binToDec {⍵⍴0},⍨-⍤⊢↓⊢⌽(decToBin⊣)

⍝ Formats arguments so that variables that contain expressions can be evaluated
formatArg ← {		
    1=1⊃⎕VFI ⍵: '(',⍵,')'				⍝ If integer, return the value wrapped in parenthesis
    ('AND' 'OR' 'NOT' 'LSHIFT' 'RSHIFT')∊⍨⊂⍵: ⍵		⍝ If logic function, return itself
    ∊ '(',⍵,' ⍬)'					⍝ Else, return the variable and beside a right argument so it will be invoked
 }

populateVar←{∊(1↑⍵),'←({⍵⊣⍵.v←¯1}⎕NS'''') lookupDict {',∊(formatArg¨' 'split ⊃1↓⍵),'}'}	⍝ Assigns expressions with cache evaluation logic to variables


⍎¨populateVar¨parseInst¨data	⍝ Initializes variables by evaluating the expresions
solutionA ← a ⍬			⍝ At this point all variables hold a function that either evaluates or retrieves its values from a dictionary, so we pass an argument to invoke the function that computes its value
⎕← solutionA			⍝ 956

⍎¨populateVar¨parseInst¨data	⍝ Reset state by reinitializing 
b ← {956}			⍝ Override b with a function that returns the previous value of a
solutionB ← a ⍬			⍝ Evaluate a again
⎕← solutionB			⍝ 956
