Extension { #name : #Array }

{ #category : #'*PhaROS' }
Array class >> forPhaROSTyping [
	^ PhaROSArrayType 
]

{ #category : #'*PhaROS' }
Array class >> named: aName ofType: aType [ 
	^ PhaROSArrayType named: aName ofType: aType 
]
