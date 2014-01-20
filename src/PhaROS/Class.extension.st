Extension { #name : #Class }

{ #category : #'*PhaROS' }
Class >> adaptToAdapter [ 
	^ PhaROSConverter convertTo: self .
]

{ #category : #'*PhaROS' }
Class >> parameterClass [
	self error: self name, ' Is not a XMLRPC legal value'.
]
