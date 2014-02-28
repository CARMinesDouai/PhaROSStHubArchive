Extension { #name : #Duration }

{ #category : #'*PhaROS' }
Duration class >> named: aName [ 
	^ PhaROSDurationType named: aName
]

{ #category : #'*PhaROS' }
Duration >> nanoSecondsField [ 
	^nanos.
]

{ #category : #'*PhaROS' }
Duration >> secondsField [ 
	^seconds 
]
