data ← ⊃⊃⎕NGET'../data/day01'1

solutionA ← +/1 ¯1⌷⍨∘⊂'()'⍳⊢		⍝ Map input to indices of '()', then map it to 1 ¯1 and reduce-sum
solutionB ← ¯1⍳⍨(+\1 ¯1⌷⍨∘⊂'()'⍳⊢)	⍝ Same mapping as above, then scan-sum and get index of first ¯1 occurrence

⎕← solutionA data    ⍝ 74
⎕← solutionB data    ⍝ 1795
