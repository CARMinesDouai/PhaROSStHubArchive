Class {
	#name : #OCNNetNameResolverTest,
	#superclass : #TestCase,
	#category : #'Ocean-Kernel-Test'
}

{ #category : #tests }
OCNNetNameResolverTest >> testExternalLookupIpv4Address [
	
	| nameToLookup address |
	
	nameToLookup := 'www.pharo-project.org'.
	address := (OCNNetNameResolver ipv4AddressForName: nameToLookup) .
	self assert: address = '212.103.66.211'.

]

{ #category : #tests }
OCNNetNameResolverTest >> testExternalLookupIpv6Address [
	
	| nameToLookup address |
	
	self signalFailure: 'to fix with an external ipv6 server'.
	nameToLookup := '???'.
	address := (OCNNetNameResolver ipv6AddressForName: nameToLookup) .
	self assert: address = '???'.

]

{ #category : #tests }
OCNNetNameResolverTest >> testLocalhostName [
	
	self assert: OCNNetNameResolver localhostName notEmpty
]

{ #category : #tests }
OCNNetNameResolverTest >> testLookupLocalhostIpv4Address [
	
	| localhostAddress |
	localhostAddress := '127.0.0.1'. "TO BE CHANGED TO an instance of IpAddress"
	
	#( 'localhost'  '127.0.0.1' ) do: [ :nameToLookup | 
		self assert: (OCNNetNameResolver ipv4AddressForName: nameToLookup)  = localhostAddress.
	]

]

{ #category : #tests }
OCNNetNameResolverTest >> testLookupLocalhostIpv4Addresses [
	
	| nameToLookup allAddresses 
	|
	nameToLookup := 'localhost'.
	allAddresses := (OCNNetNameResolver ipv4AddressesForName: nameToLookup) .
	self assert: allAddresses isCollection.

	self signalFailure: 'to finish'
	"allAddresses do: [ :anAddress | 
		self assert: (anAddress isKindOf: OCNIPV4Address).	
	]"
	
]

{ #category : #tests }
OCNNetNameResolverTest >> testLookupLocalhostIpv6Address [
	
	| localhostAddress |
	localhostAddress := '::1'. "TO BE CHANGED TO an instance of IpAddress"
	
	#( 'localhost'  '::1' ) do: [ :nameToLookup | 
		self assert: (OCNNetNameResolver ipv6AddressForName: nameToLookup)  = localhostAddress.
	]

]

{ #category : #tests }
OCNNetNameResolverTest >> testLookupLocalhostIpv6Addresses [
	
	| nameToLookup allAddresses 
	|
	nameToLookup := 'localhost'.
	allAddresses := (OCNNetNameResolver ipv6AddressesForName: nameToLookup) .
	self assert: allAddresses isCollection.

	self signalFailure: 'to finish'
	"allAddresses do: [ :anAddress | 
		self assert: (anAddress isKindOf: OCNIPV6Address).	
	]"
	
]

{ #category : #tests }
OCNNetNameResolverTest >> testLookupUnknownNameToIpv4Address [
	
	| nameToLookup address |
	
	nameToLookup := 'www.thatneverwillexistwebsite.org'.
	self should: [OCNNetNameResolver ipv4AddressForName: nameToLookup] raise: OCNNameLookupError.
	
]

{ #category : #tests }
OCNNetNameResolverTest >> testLookupUnknownNameToIpv4Addresses [
	
	| nameToLookup |
	
	nameToLookup := 'www.thatneverwillexistwebsite.org'.
	self should: [OCNNetNameResolver ipv4AddressesForName: nameToLookup] raise: OCNNameLookupError.
	
]

{ #category : #tests }
OCNNetNameResolverTest >> testLookupUnknownNameToIpv6Address [
	
	| nameToLookup address |
	
	nameToLookup := 'www.thatneverwillexistwebsite.org'.
	self should: [OCNNetNameResolver ipv6AddressForName: nameToLookup] raise: OCNNameLookupError.
	
]

{ #category : #tests }
OCNNetNameResolverTest >> testLookupUnknownNameToIpv6Addresses [
	
	| nameToLookup |
	
	nameToLookup := 'www.thatneverwillexistwebsite.org'.
	self should: [OCNNetNameResolver ipv6AddressesForName: nameToLookup] raise: OCNNameLookupError.
	
]

{ #category : #tests }
OCNNetNameResolverTest >> testLoopBackIpv4Address [
	
	self assert: OCNNetNameResolver loopBackIpv4Address = '127.0.0.1'
]

{ #category : #tests }
OCNNetNameResolverTest >> testLoopBackIpv6Address [
	
	self assert: OCNNetNameResolver loopBackIpv6Address = '::1'
]

{ #category : #tests }
OCNNetNameResolverTest >> testLoopBackName [
	
	self assert: OCNNetNameResolver loopBackName = 'localhost' 
]
