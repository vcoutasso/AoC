⎕IO ← 0                                 ⍝ Set 0 based indexing

data ← 'hepxcrrq'

lc ← ¯1 ⎕C ⎕A                           ⍝ Lowercase alphabet

incrementString←{
    enc ← (⍴lc)⊥lc⍸⍵                    ⍝ Use decoding to get a numeric representation of the string
    idx ← ((⍴⍵)⍴⍴lc)⊤1+enc              ⍝ Increment by one and get the indices for the new letters
    lc[idx]                             ⍝ Construct the string with the provided indices
}

isValid ← {
    A ← ~∨/'iof'∊⍵                      ⍝ Check membership of i, o and l, then reduce or and negate to ensure there are none
    B ← ∨/,↑(⍵⍷⍨⊢)¨¯1↓1↓⊂⍤⊢⌺3⊢lc        ⍝ Stride by 3 to get increasing triplets from the alphabet, drop last and first cause padding, search for them in the string, ravel and reduce or
    C ← 2≤+/∨/↑(⍵⍷⍨⊢)¨⊂⍤⊢⌺(⍪2 2)⊢2/lc   ⍝ Stride by 2 skipping one so that there is no overlap, search for the pairs in the string, mix, reduce or to find ocurrences, reduce sum to find how many, ensure eq or greater than two
    A ∧ B ∧ C                           ⍝ Logic and between requirements
}

nextPassword ← { 
    ({incrementString ⍵}⍣{isValid ⍺})⍵  ⍝ Use the power operator to loop while the string is not valid, incrementing it every step
}

⎕← newPwd ← nextPassword data           ⍝ hepxxyzz    
⎕← nextPassword newPwd                  ⍝ heqaabcc
