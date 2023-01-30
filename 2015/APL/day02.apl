data ← ⎕CSV⍠'Separator' 'x'⊢'../data/day02'⍬4

⍝ Multiply argument by itself (vertically) shifted one to the right, then use it as the right argument to a fork that
⍝ sums the min across rows with 2 × the sum across rows, and finally reduce-sum
solutionA ← +/((⌊/+2×+/)⊢×¯1⌽⊢)
⍝ Sort each row in ascending order (thanks aplcart), take the first two columns, sum across rows and multiply by 2
⍝ then add that to the row-wise reduce-multiply of the input and lastly reduce-sum 
solutionB ← {+/(×/⍵) + 2×+/¯1↓[2]((⊂∘⍋⌷⊢)⍤1)⍵}

⎕← solutionA data   ⍝ 1588178
⎕← solutionB data   ⍝ 3783758
