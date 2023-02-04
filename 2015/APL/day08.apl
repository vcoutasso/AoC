data ← ⊃⎕NGET '../data/day08' 1

⍝ Get rid of the ambiguous triple and pairs of double backslashes by replacing them, iterate pairwise, compare the occurrences returning their corresponsing values and reduce-sum
solutionA ← { +/2+{+/{'\x'≡⍵:3 ⋄ '\"'≡⍵:1 ⋄ '⌿⌿'≡⍵:1 ⋄ '⍀⍀'≡⍵:2 ⋄ 0}¨⍵}¨(⊂⍤⊢⌺2)¨'⌿⌿⌿⌿'⎕R'⍀⍀'⊢'\\\\'⎕R'⌿⌿'⊢¨⍵ }
⍝ Count occurrences of " and \ in each string, reduce-sum, add 2 for the enclosing ", reduce-sum
solutionB ← +/2+(+/'"'∘⍷,'\'∘⍷)¨

⎕←solutionA data	⍝ 1350
⎕←solutionB data	⍝ 2085
