Class {
	#name : #IpAddressTest,
	#superclass : #TestCase,
	#category : #'Ocean-KernelTests'
}

{ #category : #coverage }
IpAddressTest class >> packageNamesUnderTest [
	^ #('Ocean-Kernel')
]

{ #category : #testing }
IpAddressTest >> testDifferentAddressesAreNotEqual [
	self deny: (OCNIpv4Address newFromString: '1.2.3.4') = (OCNIpv4Address newFromString: '1.2.3.5')
]

{ #category : #testing }
IpAddressTest >> testEquality [
	self assert: (OCNIpv4Address newFromString: '127.0.0.1') = (OCNIpv4Address newFromString: '127.0.0.1')
]

{ #category : #testing }
IpAddressTest >> testInvalidPort [
	self should: [OCNIpv4Address loopbackAddressWithPort: 65536] raise: OCNInvalidIpAddress.
	self should: [OCNIpv4Address loopbackAddressWithPort: 0] raise: OCNInvalidIpAddress.
	self should: [OCNIpv4Address loopbackAddressWithPort: -1234] raise: OCNInvalidIpAddress.

]

{ #category : #testing }
IpAddressTest >> testNewFromString [
	{ '192.168.0.1.9' . 'are.122.34.2' . '' . '255.256.0.0'. '1.2.3' } do: [ :each | 
		self should: [ OCNIpv4Address newFromString: each ] raise: OCNInvalidIpStringAddressError ].
	
	{ '192.168.0.1' . '0.0.0.0' . '255.255.255.255' } do: [ :each | 
		self assert: (OCNIpv4Address newFromString: each) isIpv4].	
		
	
]

{ #category : #testing }
IpAddressTest >> testValidPort [
	self shouldnt: [OCNIpv4Address loopbackAddressWithPort: 65535] raise: OCNInvalidIpAddress.
	self shouldnt: [OCNIpv4Address loopbackAddressWithPort: 1] raise: OCNInvalidIpAddress.
	self shouldnt: [OCNIpv4Address loopbackAddressWithPort: 32245] raise: OCNInvalidIpAddress.

]
