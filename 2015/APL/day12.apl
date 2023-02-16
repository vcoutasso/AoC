data ← ⊃⎕NGET '../data/day12'1

numbers ← { ⍎⍕('-'⎕R'¯')'[^0-9-]'⎕R' '⊢⍵ }              ⍝ Replace everything thats not a number or a - with spaces, replace - with ¯

validValues ← {
    keys ← ⍵.⎕NL¯2                                      ⍝ Get JSON keys
    values ← keys {0=≢⍺:⍬ ⋄ ⍵.(⍎¨⍺)} ⍵                  ⍝ Get JSON values or empty array
    (⊂'red')∊values:0                                   ⍝ Check if 'red' is a value of the object, and if so return 0
    nested ← ⍵.⎕NL¯9                                    ⍝ Get nested objects
    0=≢nested:values                                    ⍝ If no nested objects, return the values
    values,∊∇¨⍵.(⍎¨⊢)nested                             ⍝ Otherwise, recurse into the nested objects and catenate
 }

partOne ← {
    +/⍎⍕numbers ⍵                                       ⍝ Turn it into a string, evaluate, reduce-sum
}

partTwo ← {
    1=2|⎕DR⍵:⍵                                          ⍝ If parameter is a number, return it
    (⍕≡⊢)⍵:0                                            ⍝ If it is a string, return 0
    ((326=⎕DR)∧(0=≡))⍵:+/∇ validValues ⍵                ⍝ If it is a pointer of depth zero, it represents a JSON that needs to go through validation
    +/∊∇¨⍵                                              ⍝ If none of the above, the parameter is a list and we call the dfn for every item, then reduce-sum
 }

⎕←partOne data         ⍝ 111754
⎕←partTwo ⎕JSON⊃data   ⍝ 65402
