Class {
	#name : #OCNIpv6NetNameResolverTest,
	#superclass : #TestCase,
	#category : #'Ocean-Kernel-Test'
}

{ #category : #'tests ipv6' }
OCNIpv6NetNameResolverTest >> testLocalHostAddresses [
	
	| allLocalhostAddresses |
	
	allLocalhostAddresses := OCNNetNameResolver localHostAddresses.
	self deny: allLocalhostAddresses isEmpty.
	self signalFailure: 'TODO test there at least one IP V6 address'.  
	"self assert: (allLocalhostAddresses anySatisfy: [ :ipAddress | ipAddress isIpv6 ])."
]

{ #category : #'tests ipv6' }
OCNIpv6NetNameResolverTest >> testLookupExternalNameIpv6Address [
	
	| nameToLookup address |
	
	self signalFailure: 'ipv6 not testable?'.
	nameToLookup := '???'.
	address := (OCNNetNameResolver ipv6AddressForName: nameToLookup) .
	self assert: address = '???'.

]

{ #category : #'tests ipv6' }
OCNIpv6NetNameResolverTest >> testLookupExternalNameIpv6Addresses [
	
	| nameToLookup allAddresses |
	
	self signalFailure: 'ipv6 not testable?'.
	nameToLookup := '???'.
	allAddresses := (OCNNetNameResolver ipv6AddressesForName: nameToLookup) .
	self assert: allAddresses isCollection.	
	self deny: allAddresses isEmpty.
	self assert: (allAddresses includes:  '???').

]

{ #category : #'tests localhost' }
OCNIpv6NetNameResolverTest >> testLookupLocalhostIpv6Address [
	
	| localhostAddress |
	localhostAddress := '::1'. "TO BE CHANGED TO an instance of Ipv6Address"
	
	#( 'localhost'  '::1' ) do: [ :nameToLookup | 
		self assert: (OCNNetNameResolver ipv6AddressForName: nameToLookup)  = localhostAddress.
	]

]

{ #category : #'tests localhost' }
OCNIpv6NetNameResolverTest >> testLookupLocalhostIpv6Addresses [
	
	| nameToLookup allAddresses |

	allAddresses := (OCNNetNameResolver ipv6AddressesForName: 'localhost') .
	self assert: allAddresses isCollection.
	self deny: allAddresses isEmpty.

	"self assert: (allAddresses allSatisfy:  [ :ipAddress |  ipAddress isIpv6 ])"
	
]

{ #category : #'tests ipv6' }
OCNIpv6NetNameResolverTest >> testLookupUnknownNameIpv6Address [
	
	| nameToLookup address |
	
	nameToLookup := 'www.thatneverwillexistwebsite.org'.
	self should: [OCNNetNameResolver ipv6AddressForName: nameToLookup] raise: OCNNameLookupError.
	
]

{ #category : #'tests ipv6' }
OCNIpv6NetNameResolverTest >> testLookupUnknownNameIpv6Addresses [
	
	| nameToLookup |
	
	nameToLookup := 'www.thatneverwillexistwebsite.org'.
	self should: [OCNNetNameResolver ipv6AddressesForName: nameToLookup] raise: OCNNameLookupError.
	
]

{ #category : #'tests loopback' }
OCNIpv6NetNameResolverTest >> testLoopBackIpv6Address [
	
	self assert: OCNNetNameResolver ipv6LoopBackAddress = '::1'
]
