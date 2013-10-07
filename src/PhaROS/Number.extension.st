Extension { #name : #Number }

{ #category : #'*PhaROS' }
Number >> asRoStByteArray [
	^{ self }.
]

{ #category : #'*PhaROS' }
Number >> multiplyQuaternionByYou: aQuaternion [
	^ PhaROSQuaternion x: aQuaternion x * self y: aQuaternion y * self  z: aQuaternion z * self  w: aQuaternion w * self .
]

{ #category : #'*PhaROS' }
Number >> signWith0Positive [
	^ self >= 0 ifTrue: [ ^ 1 ] ifFalse: [ ^ -1 ].
]
