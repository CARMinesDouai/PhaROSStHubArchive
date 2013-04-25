Extension { #name : #Symbol }

{ #category : #'*PhaROS' }
Symbol >> adapToAdapter [ 
	^ (self at:1) isLowercase ifTrue: [
		PhaROSFilter for: self.	
	] ifFalse: [
		PhaROSConverter convertTo: (Smalltalk at: self ifAbsent: [ self error: ' The target class does not exist']).
	].
]
