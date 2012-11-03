Class {
	#name : #OCNIpv6NetNameResolverTest,
	#superclass : #TestCase,
	#category : #'Ocean-IpV6'
}

{ #category : #'tests ipv6' }
OCNIpv6NetNameResolverTest >> nameResolver [
	^ OCNNetNameResolverIpV6
]

{ #category : #'tests ipv6' }
OCNIpv6NetNameResolverTest >> testLookupExternalNameIpv6Address [
	
	| nameToLookup address |
	
	nameToLookup := 'www.ipv6.apple.com'.
	address := (self nameResolver ipv6AddressForName: nameToLookup) .
	self assert: (address isKindOf: OCNIpv6Address).
	self assert: (address ip includes: $:)

]

{ #category : #'tests ipv6' }
OCNIpv6NetNameResolverTest >> testLookupExternalNameIpv6Addresses [
	
	| nameToLookup allAddresses |
	
	nameToLookup := 'www.ipv6.apple.com'.
	allAddresses := (self nameResolver ipv6AddressesForName: nameToLookup) .
	self assert: allAddresses isCollection.	
	self deny: allAddresses isEmpty.
	self assert: (allAddresses anySatisfy:[:anAddress | anAddress isIpv6 ]).

]

{ #category : #'tests localhost' }
OCNIpv6NetNameResolverTest >> testLookupLocalhostIpv6Address [
	
	| localhostAddress |
	localhostAddress := '::1'. "TO BE CHANGED TO an instance of Ipv6Address"
	
	#( 'localhost'  '::1' ) do: [ :nameToLookup | 
		self assert: (self nameResolver ipv6AddressForName: nameToLookup) ip  = localhostAddress.
	]

]

{ #category : #'tests localhost' }
OCNIpv6NetNameResolverTest >> testLookupLocalhostIpv6Addresses [
	
	| nameToLookup allAddresses |

	allAddresses := (self nameResolver ipv6AddressesForName: 'localhost') .
	self assert: allAddresses isCollection.
	self deny: allAddresses isEmpty.

	"self assert: (allAddresses allSatisfy:  [ :ipAddress |  ipAddress isIpv6 ])"
	
]

{ #category : #'tests ipv6' }
OCNIpv6NetNameResolverTest >> testLookupUnknownNameIpv6Address [
	
	| nameToLookup address |
	
	nameToLookup := 'www.thatneverwillexistwebsite.org'.
	self should: [self nameResolver ipv6AddressForName: nameToLookup] raise: OCNNameLookupError.
	
]

{ #category : #'tests ipv6' }
OCNIpv6NetNameResolverTest >> testLookupUnknownNameIpv6Addresses [
	
	| nameToLookup |
	
	nameToLookup := 'www.thatneverwillexistwebsite.org'.
	self should: [self nameResolver ipv6AddressesForName: nameToLookup] raise: OCNNameLookupError.
	
]

{ #category : #'tests loopback' }
OCNIpv6NetNameResolverTest >> testLoopBackIpv6Address [
	
	self assert: (self nameResolver ipv6LoopBackAddress isIpv6).
	self assert: self nameResolver ipv6LoopBackAddress ip = '::1'.
	
]
