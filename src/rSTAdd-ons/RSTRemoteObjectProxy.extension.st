Extension { #name : #RSTRemoteObjectProxy }

{ #category : #'*rSTAdd-ons' }
RSTRemoteObjectProxy >> xxxSend: aMessage [ 
	"send this message to the remote object represented by me"
	^ RSTBroker isStarted
		ifTrue: [RSTBroker instance sendMessage: aMessage to: self xxxRemoteObjectID]
		ifFalse:[self error: 'rST: service not started']
]
