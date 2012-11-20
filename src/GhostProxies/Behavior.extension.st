Extension { #name : #Behavior }

{ #category : #'*GhostProxies' }
Behavior >> ghostFindClassWithNilMethodDictInHierarchy [
	methodDict isNil 
		ifTrue: [ ^ self ]
		ifFalse: [ 
			superclass == nil 
				ifTrue: [ ^ nil]
				ifFalse: [ ^ CompiledMethod receiver: superclass withArguments: #() executeMethod: (Behavior >> #ghostFindClassWithNilMethodDictInHierarchy) ]]
]
