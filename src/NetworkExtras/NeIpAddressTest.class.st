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

{ #category : #testing }
NeIpAddressTest >> testCompareAddresses [
	self assert: '1.1.1.1' asIpAddress < '2.2.2.2' asIpAddress.
	self assert: '2.2.2.2' asIpAddress > '1.1.1.1' asIpAddress.
	self assert: '0.2.0.0' asIpAddress < '1.0.0.0' asIpAddress.
	self assert: '1.1.1.1' asIpAddress > '0.2.0.0' asIpAddress.
	
	
]
