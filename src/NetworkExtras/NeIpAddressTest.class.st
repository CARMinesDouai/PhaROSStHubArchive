Class {
	#name : #NeIpAddressTest,
	#superclass : #TestCase,
	#traits : 'NeTWait',
	#classTraits : 'NeTWait classTrait',
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #testing }
NeIpAddressTest >> testAddressName [
	self assert: NeIpAddress loopback name equals: 'localhost'.
	self assert: NeIpAddress broadcast name equals: 'broadcasthost'.
	
]
