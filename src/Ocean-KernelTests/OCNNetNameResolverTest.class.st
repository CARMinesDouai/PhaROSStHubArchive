Class {
	#name : #OCNNetNameResolverTest,
	#superclass : #TestCase,
	#category : #'Ocean-KernelTests'
}

{ #category : #coverage }
OCNNetNameResolverTest class >> packageNamesUnderTest [
	^ #('Ocean-Kernel' 'Ocean-LibraryPlugin')
]

{ #category : #'tests localhost' }
OCNNetNameResolverTest >> testAllLocalHostAddresses [
	
	| allLocalhostAddresses ipV4Addresses ipV6Addresses |
	
	allLocalhostAddresses := OCNNetNameResolver localHostAddresses.
	self deny: allLocalhostAddresses isEmpty.
	ipV4Addresses := allLocalhostAddresses select:  [:ipAddress | ipAddress isIpv4].
	ipV6Addresses := allLocalhostAddresses copyWithoutAll: ipV4Addresses.
	self assert: (ipV4Addresses allSatisfy: [ :ipAddress | ipAddress isIpv4]).  
	ipV4Addresses ifNotEmpty: [
		self deny: (ipV4Addresses allSatisfy: [ :ipAddress | ipAddress isIpv6])].  
	self assert: (ipV6Addresses allSatisfy: [ :ipAddress | ipAddress isIpv6]).  
	ipV6Addresses ifNotEmpty: [
		self deny: (ipV6Addresses allSatisfy: [ :ipAddress | ipAddress isIpv4])].  

]

{ #category : #'tests localhost' }
OCNNetNameResolverTest >> testLocalHostName [
	
	self assert: OCNNetNameResolver localHostName notEmpty
]

{ #category : #'tests loopback' }
OCNNetNameResolverTest >> testLoopBackName [
	
	self assert: OCNNetNameResolver loopBackName = 'localhost' 
]
