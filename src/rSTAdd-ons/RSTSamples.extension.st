Extension { #name : #RSTSamples }

{ #category : #'*rSTAdd-ons' }
RSTSamples classSide >> serverBrokerID [
	^ RSTBroker defaultAddress asIpString , ':' , self serverPort asString
]
