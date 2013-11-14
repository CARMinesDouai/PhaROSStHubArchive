Extension { #name : #Array }

{ #category : #'*TaskIT' }
Array >> asArguments [
| converting |
	converting := self .
	[ (converting isArray and: [converting size = 1 and: [( converting at: 1 ) isKindOf:TKTPlanResult]])] whileTrue:[  
		converting := (converting at:1 ) arguments .	
	].
	^ converting
]
