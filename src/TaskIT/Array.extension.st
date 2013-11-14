Extension { #name : #Array }

{ #category : #'*TaskIT' }
Array >> asArguments [
		^ (self size = 1 and: [( self at: 1 ) isKindOf:TKTPlanResult]) ifTrue: [ 
			(self at:1 ) arguments.
		 ] ifFalse: [ 
			self.
		 ]
		
]
