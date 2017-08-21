Class {
	#name : #NeIpAddressTest,
	#superclass : #TestCase,
	#traits : 'NeTWait',
	#classTraits : 'NeTWait classTrait',
	#category : #'NetworkExtras-Kernel'
}

{ #category : #testing }
NeIpAddressTest >> testAddressName [
	self assert: NeIpV4Address loopback name equals: 'localhost'.
	self assert: NeIpV4Address broadcast name equals: 'broadcasthost'.
	
]
