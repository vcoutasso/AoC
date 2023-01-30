data ← ⊃⊃⎕NGET'../data/day03'1

houses ← {
	⍝ Compute the outer product comparing all possible chars with the provided input and multiply the resulting odd rows by -1 so that
	⍝ both the horizontal and vertical steps have a positive and a negative value (-1 for left/down, 1 for right/up) and store the values in p
	p ← -@1 3⌷'<>v^'∘.=⍵
	⍝ Reduce-sum along first axis (how much the axis changed for every step) then scan-sum (accumulate changes) (all of this separately for x and y),
	⍝ then laminate, transpose, get the unique values and ravel
	,∪↓⍉↑⍪2(↑,⍥↓⍥(+\+⌿)↓)p
}
⍝ Get the number of major cells after calling houses on the input
solutionA ← ≢∘houses ⊢
⍝ Compute houses separately for odd and even indices, then count how many unique houses there are
solutionB ← {≢∪,↑houses¨(⊂¨⍸¨,↑(1↑⊢,1↓⊢)⊂((~,⊢)⊂2|⍳⍴⍵))⌷¨⊂⍵}

⎕← solutionA data    ⍝ 2572
⎕← solutionB data    ⍝ 2631
