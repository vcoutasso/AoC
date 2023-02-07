'pmat'⎕CY'dfns'

data ← ' '(≠⊆⊢)¨'( to | = )'⎕R' '⊃⎕NGET'../data/day09'1         ⍝ Patterns matching everyting that we are not interested in the string and removes it, leaving just the city names and distances separated by spaces

distances ← ⍎¨3⊃¨⊢                                              ⍝ Extracts the distance values and converts from string to int by evaluating the expression

rows ← {
     ⍺ ← 7                                                      ⍝ Default value of 7 because thats how many distances for the first city that we have
     1=≢⍵: ⊂⍵                                                   ⍝ When we get down to a single element, we return it enclosed
     r ← ⊂⍺↑⍵                                                   ⍝ Take first ⍺ elements from ⍵
     r, (⍺-1)∇⍺↓⍵                                               ⍝ Append the row of distances we just got with the result for the next cities (recursively decrements ⍺ and drops elements from the original list until there's only one left)
 }

 pathDistances ← {
     adjacencyMatrix ← (⍉+⊢)(↑{((8-⍴⍵)/0),⍵}¨rows ⍵)⍪0          ⍝ Appends 0s to the left until we have 8 elements for every row, laminates a new row of zeroes, and add this matrix to the transpose of itself
     +/adjacencyMatrix[↓∊⍤⊢⌺1 2⊢pmat 8]                         ⍝ For every permutation of a  8x8 matrix, get the starting and ending city index for every step of the way, get those values from the matrix and reduce-sum to calculate path length
 }

 partOne ← ⌊/⍤pathDistances ⊢                                   ⍝ Minimum length of all paths
 partTwo ← ⌈/⍤pathDistances ⊢                                   ⍝ Maximum length of all paths

 allDistances ← distances data                                  ⍝ Array of distances between cities as seen in the problem input

 ⎕ ← partOne allDistances       ⍝ 141
 ⎕ ← partTwo allDistances       ⍝ 736
