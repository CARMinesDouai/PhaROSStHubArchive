Extension { #name : #Array }

{ #category : #'*PhaROS' }
Array >> asSensors [
	^ PhaROSSensorMultiplexor with: self.
]
