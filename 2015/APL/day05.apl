data ← ⊃⎕NGET '../data/day05'1

solutionA ← {
	+/⊃∧/(3≤+/¨+⌿'aeiou'∘.=⍵) (∨/1↓[2]↑(¯1⌽¨⍵)=⍵) (∧/~+⌿('ab' 'cd' 'pq' 'xy')∘.≡↓↑↑(⊂⊢⌺2)¨⍵)
}
solutionB ← {
	+/(∨/2↓[2]↑(¯2⌽¨⍵)=⍵) ∧ ({∨/1>⍨|(⊃idx)-⍵⍳⍵⌷⍨idx←⊂(⍳⍴⍵)~⍵⍳∪⍵}¨↓↓↑↑(⊂⊢⌺2)¨⍵)
}

⎕← solutionA data    ⍝ 238
⎕← solutionB data    ⍝ 69
