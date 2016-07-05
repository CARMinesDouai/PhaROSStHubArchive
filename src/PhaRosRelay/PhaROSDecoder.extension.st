Extension { #name : #PhaROSDecoder }

{ #category : #'*PhaRosRelay' }
PhaROSDecoder >> dataByteArray: size [
	self verifyDataAvailability: size.
	^PrDataArray data: (stream next: size).

]
