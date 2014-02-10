Extension { #name : #Time }

{ #category : #'*PhaROS' }
Time class >> named: aName [  
	^ PhaROSTimeType named: aName  
]

{ #category : #'*PhaROS' }
Time >> nanoSecondsField [ 
	^ nanos.
]

{ #category : #'*PhaROS' }
Time >> secondsField [
	^ seconds
]
