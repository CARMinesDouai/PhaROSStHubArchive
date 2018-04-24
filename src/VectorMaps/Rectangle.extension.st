Extension { #name : #Rectangle }

{ #category : #'*VectorMaps' }
Rectangle >> asVMRectangle [
	^(VMRectangle origin: self origin corner: self corner).
]

{ #category : #'*VectorMaps' }
Rectangle >> flipY [
	^self species point: self origin flipY point: self corner flipY.
]
