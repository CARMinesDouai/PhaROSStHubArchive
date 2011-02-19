Class {
	#name : #OCNNetNameResolverTest,
	#superclass : #TestCase,
	#category : #'Ocean-Kernel-Test'
}

{ #category : #'tests localhost' }
OCNNetNameResolverTest >> testLocalHostAddresses [
	
	| allLocalhostAddresses |
	
	self signalFailure: 'ipv6 not testable?'.
	allLocalhostAddresses := OCNNetNameResolver localHostAddresses.
	self deny: allLocalhostAddresses isEmpty.
	"self assert: (allLocalhostAddresses anySatisfy: [ :ipAddress | ipAddress isIpv4 ]).  
	self assert: (allLocalhostAddresses anySatisfy: [ :ipAddress | ipAddress isIpv6 ])."
]

{ #category : #'tests localhost' }
OCNNetNameResolverTest >> testLocalHostName [
	
	self assert: OCNNetNameResolver localHostName notEmpty
]

{ #category : #'tests ipv4' }
OCNNetNameResolverTest >> testLookupExternalNameIpv4Address [
	
	| nameToLookup address |
	
	nameToLookup := 'www.pharo-project.org'.
	address := (OCNNetNameResolver ipv4AddressForName: nameToLookup) .
	self assert: address = '212.103.66.211'.

]

{ #category : #'tests ipv4' }
OCNNetNameResolverTest >> testLookupExternalNameIpv4Addresses [
	
	| nameToLookup allAddresses |
	
	nameToLookup := 'www.pharo-project.org'.
	allAddresses := (OCNNetNameResolver ipv4AddressesForName: nameToLookup) .
	self assert: allAddresses isCollection.	
	self deny: allAddresses isEmpty.
	self assert: (allAddresses includes:  '212.103.66.211').

]

{ #category : #'tests ipv6' }
OCNNetNameResolverTest >> testLookupExternalNameIpv6Address [
	
	| nameToLookup address |
	
	self signalFailure: 'ipv6 not testable?'.
	nameToLookup := '???'.
	address := (OCNNetNameResolver ipv6AddressForName: nameToLookup) .
	self assert: address = '???'.

]

{ #category : #'tests ipv6' }
OCNNetNameResolverTest >> testLookupExternalNameIpv6Addresses [
	
	| nameToLookup allAddresses |
	
	self signalFailure: 'ipv6 not testable?'.
	nameToLookup := '???'.
	allAddresses := (OCNNetNameResolver ipv6AddressesForName: nameToLookup) .
	self assert: allAddresses isCollection.	
	self deny: allAddresses isEmpty.
	self assert: (allAddresses includes:  '???').

]

{ #category : #'tests localhost' }
OCNNetNameResolverTest >> testLookupLocalhostIpv4Address [
	
	| localhostAddress |
	localhostAddress := '127.0.0.1'. "TO BE CHANGED TO an instance of Ipv4Address"
	
	#( 'localhost'  '127.0.0.1' ) do: [ :nameToLookup | 
		self assert: (OCNNetNameResolver ipv4AddressForName: nameToLookup)  = localhostAddress.
	]

]

{ #category : #'tests localhost' }
OCNNetNameResolverTest >> testLookupLocalhostIpv4Addresses [
	
	|  allAddresses |
	allAddresses := (OCNNetNameResolver ipv4AddressesForName: 'localhost') .
	self assert: allAddresses isCollection.
	self deny: allAddresses isEmpty.
	
	"self assert: (allAddresses allSatisfy:  [ :ipAddress |  ipAddress isIpv4 ])"
	
]

{ #category : #'tests localhost' }
OCNNetNameResolverTest >> testLookupLocalhostIpv6Address [
	
	| localhostAddress |
	localhostAddress := '::1'. "TO BE CHANGED TO an instance of Ipv6Address"
	
	#( 'localhost'  '::1' ) do: [ :nameToLookup | 
		self assert: (OCNNetNameResolver ipv6AddressForName: nameToLookup)  = localhostAddress.
	]

]

{ #category : #'tests localhost' }
OCNNetNameResolverTest >> testLookupLocalhostIpv6Addresses [
	
	| nameToLookup allAddresses |

	allAddresses := (OCNNetNameResolver ipv6AddressesForName: 'localhost') .
	self assert: allAddresses isCollection.
	self deny: allAddresses isEmpty.

	"self assert: (allAddresses allSatisfy:  [ :ipAddress |  ipAddress isIpv6 ])"
	
]

{ #category : #'tests ipv4' }
OCNNetNameResolverTest >> testLookupUnknownNameIpv4Address [
	
	| nameToLookup address |
	
	nameToLookup := 'www.thatneverwillexistwebsite.org'.
	self should: [OCNNetNameResolver ipv4AddressForName: nameToLookup] raise: OCNNameLookupError.
	
]

{ #category : #'tests ipv4' }
OCNNetNameResolverTest >> testLookupUnknownNameIpv4Addresses [
	
	| nameToLookup |
	
	nameToLookup := 'www.thatneverwillexistwebsite.org'.
	self should: [OCNNetNameResolver ipv4AddressesForName: nameToLookup] raise: OCNNameLookupError.
	
]

{ #category : #'tests ipv6' }
OCNNetNameResolverTest >> testLookupUnknownNameIpv6Address [
	
	| nameToLookup address |
	
	nameToLookup := 'www.thatneverwillexistwebsite.org'.
	self should: [OCNNetNameResolver ipv6AddressForName: nameToLookup] raise: OCNNameLookupError.
	
]

{ #category : #'tests ipv6' }
OCNNetNameResolverTest >> testLookupUnknownNameIpv6Addresses [
	
	| nameToLookup |
	
	nameToLookup := 'www.thatneverwillexistwebsite.org'.
	self should: [OCNNetNameResolver ipv6AddressesForName: nameToLookup] raise: OCNNameLookupError.
	
]

{ #category : #'tests loopback' }
OCNNetNameResolverTest >> testLoopBackIpv4Address [
	
	self assert: OCNNetNameResolver ipv4LoopBackAddress = '127.0.0.1'
]

{ #category : #'tests loopback' }
OCNNetNameResolverTest >> testLoopBackIpv6Address [
	
	self assert: OCNNetNameResolver ipv6LoopBackAddress = '::1'
]

{ #category : #'tests loopback' }
OCNNetNameResolverTest >> testLoopBackName [
	
	self assert: OCNNetNameResolver loopBackName = 'localhost' 
]
