Extension { #name : #Symbol }

{ #category : #'*PhaROS' }
Symbol >> adaptToAdapter [ 
	^ (self at:1) isLowercase ifTrue: [
		PhaROSFilter for: self.	
	] ifFalse: [
		PhaROSConverter convertTo: (Smalltalk at: self ifAbsent: [ self error: ' The target class does not exist']).
	].
]

{ #category : #'*PhaROS' }
Symbol >> asDateAndTime [
	^ self = #now ifTrue: [ DateAndTime now ] ifFalse: [ super asDateAndTime ].
]

{ #category : #'*PhaROS' }
Symbol >> asPhaROSController [ 
	^ self value: PhaROSHandleController.
]
