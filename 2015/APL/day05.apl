data ← ⊃⎕NGET '../data/day05'1

solutionA ← {
	A ← 3≤+/¨+⌿'aeiou'∘.=⍵                                  ⍝ Calculate outer product with vowels then reduce-sum along first axis and map reduce-sum, then check if ≥ 3 for a boolean mask
	B ← ∨/1↓[2]↑(¯1⌽¨⍵)=⍵                                   ⍝ Compare the input to itself shifted one to the right, mix, remove the first column (cause the last wrapped around) and reduce-logical or
	C ← ∧/~+⌿('ab' 'cd' 'pq' 'xy')∘.≡↓↑↑(⊂⊢⌺2)¨⍵	        ⍝ Generate all subsequent pairs of characters from the input and check if any of the invalid exists, reduce-sum along first axis, negate and reduce-logical and
	+/⊃∧/A B C                                              ⍝ Check if all the criteria are met by applying a reduce-logical and then reduce-sum
}
solutionB ← {
	A ← ∨/2↓[2]↑(¯2⌽¨⍵)=⍵                                   ⍝ Compare the input to itself shifted two to the right, mix, remove the first two columns (cause the last ones wrapped around) and reduce-logical or
	B ← {∨/1>⍨|(⊃idx)-⍵⍳⍵⌷⍨idx←⊂(⍳⍴⍵)~⍵⍳∪⍵}¨↓↓↑↑(⊂⊢⌺2)¨⍵	⍝ Generate all subsequent pairs of characters from the input, get the indices of those that repeat, compare it with the indices of the first occurences and check if greater than one, then reduce-or
	+/A ∧ B                                                 ⍝ Perform a logical and between the criteria and reduce-sum
}

⎕← solutionA data    ⍝ 238
⎕← solutionB data    ⍝ 69
