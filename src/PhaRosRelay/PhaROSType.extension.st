Extension { #name : #PhaROSType }

{ #category : #'*PhaRosRelay' }
PhaROSType >> newPacket [
	^ PrROSPacket type: self
]
