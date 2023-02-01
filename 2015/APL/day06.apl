⎕IO ← 0

data ← (⊂⍤1)1∘⎕C¨↑⊃⎕NGET'../data/day06'1

⍝ Parses input instruction and maps the required action to known integer values
parseInstruction ← { +/,↑-@1⊢(1↑⍵)⍷⍨¨'ON' 'TOGGLE' }

⍝ Parses input instruction for the start and end coordinates and constructs indices that represent the interval
getIndices ← {
	coords  ← ↑,⍎∘⍕¨↑' '(≠⊆⊢)¨(⊂⎕A)~⍨¨⍵		⍝ Retrieve start and end coordinates 
	(⌊⌿coords)+⍳¨1+|-⌿coords			⍝ Derive a list of x and y indices represented by the coordinates
}

⍝ Recursive solution for part one
nextA ← {
 	0=≢⍺: ⍵						⍝ Guard statement to return early if there are no more instructions
	inst    ← 1↑⍺					⍝ Retrieve first instruction
	action  ← parseInstruction inst			⍝ Array of actions where 1: turn on, 0: turn off, and ¯1: toggle
	indices ← getIndices inst			⍝ Derive a list of x and y indices represented by the coordinates
	lights	← ⍵					⍝ Copy the matrix lights matrix so we can modify it
 	⍝ Update the lights matrix in the calculated indices with the appropriate value
  	lights[⊃1↑indices;⊃1↓indices] ← { ⍵≠¯1: ⍵ ⋄  ~(lights[⊃1↑indices;⊃1↓indices])}action
	(1↓⍺)∇lights					⍝ Drop current instruction and recurse with the rest
}

⍝ Recursive solution for part two
nextB ← {
 	0=≢⍺: ⍵						⍝ Guard statement to return early if there are no more instructions
	inst    ← 1↑⍺					⍝ Retrieve first instruction
	action  ← 2 ¯1 1[1+parseInstruction inst]	⍝ Translate previous instruction values to represent brightness
	indices ← getIndices inst			⍝ Array of actions where 1: turn on, 0: turn off, and ¯1: toggle
	lights	← ⍵					⍝ Copy the matrix lights matrix so we can modify it
	⍝ Increment brightness by the value given by action
  	lights[⊃1↑indices;⊃1↓indices] ← 0⌈action + lights[⊃1↑indices;⊃1↓indices]
	(1↓⍺)∇lights					⍝ Drop current instruction and recurse with the rest
}

solutionA ← { +/,⍵ nextA 1000 1000⍴0 }
solutionB ← { +/,⍵ nextB 1000 1000⍴0 }

⎕← solutionA data    ⍝ 400410
⎕← solutionB data    ⍝ 15343601

