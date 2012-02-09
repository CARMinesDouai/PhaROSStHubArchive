Extension { #name : #Behavior }

{ #category : #'*GhostProxies' }
Behavior >> methodDict [
	methodDict == nil ifTrue: ["self manageMDFault" ^ self emptyMethodDictionary  ].
	^ methodDict
]
