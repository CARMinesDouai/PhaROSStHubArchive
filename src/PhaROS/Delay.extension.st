Extension { #name : #Delay }

{ #category : #'*PhaROS' }
Delay class >> forRate: anAmmountOfHz [
	^ self forMilliseconds: (1000/anAmmountOfHz)
]
