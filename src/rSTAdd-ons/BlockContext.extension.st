Extension { #name : #BlockContext }

{ #category : #'*rSTAdd-ons' }
BlockContext >> valueAt: aHost port: aPort [ 
	"Evaluates the receiver in the context of aHost using
	aSandstoneSession."
	self assert: aHost isIpAddress.

	^ ('rst@', aHost ,':', aPort asString) asLocalObject 
		remoteValuableValue: (RSTRemoteValuable for: self) 
]
