Class {
	#name : #IpAddressTest,
	#superclass : #TestCase,
	#category : #'Ocean-KernelTests'
}

{ #category : #'as yet unclassified' }
IpAddressTest >> testEquality [
	self assert: (OCNIpv4Address newFromString: '127.0.0.1') = (OCNIpv4Address newFromString: '127.0.0.1')
]

{ #category : #'as yet unclassified' }
IpAddressTest >> testNewFromString [
	{ '192.168.0.1.9' . 'are.122.34.2' . '' . '255.256.0.0'. '1.2.3' } do: [ :each | 
		self should: [ OCNIpv4Address newFromString: each ] raise: OCNInvalidIpStringAddressError ].
	
	{ '192.168.0.1' . '0.0.0.0' . '255.255.255.255' } do: [ :each | 
		self assert: (OCNIpv4Address newFromString: each) isIpv4].	
		
	
]
