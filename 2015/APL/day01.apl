data ← ⊃⊃⎕NGET'../data/day01'1

solutionA ← +/1 ¯1⌷⍨∘⊂'()'⍳⊢
solutionB ← ¯1⍳⍨(+\1 ¯1⌷⍨∘⊂'()'⍳⊢)

⎕← solutionA data    ⍝ 74
⎕← solutionB data    ⍝ 1795
