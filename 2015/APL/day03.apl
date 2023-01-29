data ← ⊃⊃⎕NGET'../data/day03'1

houses ← {
	p ← -@1 3⌷'<>^v'∘.=⍵
	,∪↓⍉↑⍪2(↑,⍥↓⍥(+\+⌿)↓)p
}
solutionA ← ⍴∘houses ⊢
solutionB ← {⍴∪,↑houses¨(⊂¨⍸¨,↑(1↑⊢,1↓⊢)⊂((~,⊢)⊂2|⍳⍴⍵))⌷¨⊂⍵}

⎕← solutionA data    ⍝ 2572
⎕← solutionB data    ⍝ 2631
