Extension { #name : #Number }

{ #category : #'*PhaROS' }
Number >> asRoStByteArray [
	^{ self }.
]

{ #category : #'*PhaROS' }
Number >> signWith0Positive [
	^ self >= 0 ifTrue: [ ^ 1 ] ifFalse: [ ^ -1 ].
]
