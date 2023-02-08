data ← '1113122113'

lookAndSay ← { ∊(⍕⍤≢,⊃)¨⍵⊂⍨1,2≠/⍵ } ⍝ 2-wise fold generating  a boolean mask for elements grouped together, use mask to partition original string, concat first element of every group with the group length, enlist

partOne ← ≢lookAndSay⍣40            ⍝ Apply lookAndSay to the output of itself 40 times, then get result length
partTwo ← ≢lookAndSay⍣50            ⍝ Apply lookAndSay to the output of itself 50 times, then get result length

⎕ ← partOne data    ⍝ 360154
⎕ ← partTwo data    ⍝ 5103798
