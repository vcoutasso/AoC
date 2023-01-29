data ← ⎕CSV⍠'Separator' 'x'⊢'../data/day02'⍬4

solutionA ← +/((⌊/+2×+/)⊢×¯1⌽⊢)
solutionB ← {+/(×/⍵) + 2×+/¯1↓[2]((⊂∘⍋⌷⊢)⍤1)⍵}

⎕← solutionA data   ⍝ 1588178
⎕← solutionB data   ⍝ 3783758
