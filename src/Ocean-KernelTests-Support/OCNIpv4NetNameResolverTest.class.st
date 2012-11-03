Class {
	#name : #OCNIpv4NetNameResolverTest,
	#superclass : #TestCase,
	#category : #'Ocean-KernelTests'
}

{ #category : #coverage }
OCNIpv4NetNameResolverTest class >> packageNamesUnderTest [
	^ #('Ocean-Kernel' 'Ocean-LibraryPlugin')
]

{ #category : #'tests ipv4' }
OCNIpv4NetNameResolverTest >> assertAddressIsValid: address [
	| ipParts |
	self assert: (address isKindOf: OCNIpv4Address).
	ipParts := address ipString subStrings: '.'.
	self assert: ipParts size = 4.
	ipParts do: [ :part | self assert: part asNumber printString = part ]
]

{ #category : #'tests localhost' }
OCNIpv4NetNameResolverTest >> testLocalHostAddress [
	
	self assertAddressIsValid:  OCNNetNameResolver ipv4LocalHostAddress
]

{ #category : #'tests loopback' }
OCNIpv4NetNameResolverTest >> testLocalhostIsMappedToLoopBackIpv4Address [
	self assert: OCNNetNameResolver ipv4LoopBackAddress = (OCNNetNameResolver ipv4AddressForName: 'localhost')
	
]

{ #category : #'tests ipv4' }
OCNIpv4NetNameResolverTest >> testLookupExternalNameIpv4Address [
	| nameToLookup address |
	nameToLookup := 'www.pharo-project.org'.
	address := OCNNetNameResolver ipv4AddressForName: nameToLookup.
	self assertAddressIsValid: address
]

{ #category : #'tests ipv4' }
OCNIpv4NetNameResolverTest >> testLookupExternalNameIpv4Addresses [
	| nameToLookup allAddresses |
	nameToLookup := 'www.pharo-project.org'.
	allAddresses := (OCNNetNameResolver ipv4AddressesForName: nameToLookup) .
	self assert: allAddresses isCollection.	
	self deny: allAddresses isEmpty.
	allAddresses do: [:anAddress| self assertAddressIsValid: anAddress].

]

{ #category : #'tests localhost' }
OCNIpv4NetNameResolverTest >> testLookupLocalhostIpv4Addresses [
	
	|  allAddresses |
	allAddresses := (OCNNetNameResolver ipv4AddressesForName: 'localhost') .
	self assert: allAddresses isCollection.
	self deny: allAddresses isEmpty.	
	self assert: (allAddresses allSatisfy:  [ :ipAddress |  ipAddress isIpv4 ])
	
]

{ #category : #'tests ipv4' }
OCNIpv4NetNameResolverTest >> testLookupUnknownNameIpv4Address [
	
	| nameToLookup address |
	
	nameToLookup := 'zork.arbitraryNameForOceanTest.thatneverwillexistwebsite'.
	self should: [OCNNetNameResolver ipv4AddressForName: nameToLookup] raise: OCNNameLookupError.
	
]

{ #category : #'tests ipv4' }
OCNIpv4NetNameResolverTest >> testLookupUnknownNameIpv4Addresses [
	
	| nameToLookup |
	
	nameToLookup := 'zork.arbitraryNameForOceanTest.thatneverwillexistwebsite'.
	self should: [OCNNetNameResolver ipv4AddressesForName: nameToLookup] raise: OCNNameLookupError.
	
]

{ #category : #'tests loopback' }
OCNIpv4NetNameResolverTest >> testLoopBackIpv4Address [
	|loopBackAddress|	
	loopBackAddress := OCNNetNameResolver ipv4LoopBackAddress.
	self assertAddressIsValid: loopBackAddress.
	self assert: loopBackAddress ip = #[127 0 0 1].
	
]
