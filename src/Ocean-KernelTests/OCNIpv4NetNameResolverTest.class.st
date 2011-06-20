Class {
	#name : #OCNIpv4NetNameResolverTest,
	#superclass : #TestCase,
	#category : #'Ocean-KernelTests'
}

{ #category : #'tests localhost' }
OCNIpv4NetNameResolverTest >> testLocalHostAddresses [
	
	| allLocalhostAddresses |
	
	allLocalhostAddresses := OCNNetNameResolver localHostAddresses.
	self deny: allLocalhostAddresses isEmpty.
	self assert: (allLocalhostAddresses anySatisfy: [ :ipAddress | ipAddress isIpv4]).  

]

{ #category : #'tests ipv4' }
OCNIpv4NetNameResolverTest >> testLookupExternalNameIpv4Address [
	
	| nameToLookup address |
	
	nameToLookup := 'www.pharo-project.org'.
	address := (OCNNetNameResolver ipv4AddressForName: nameToLookup).
	self assert: (address isKindOf: OCNIpv4Address).
	self assert: address ip = '212.103.66.211'.

]

{ #category : #'tests ipv4' }
OCNIpv4NetNameResolverTest >> testLookupExternalNameIpv4Addresses [
	
	| nameToLookup allAddresses |
	
	nameToLookup := 'www.pharo-project.org'.
	allAddresses := (OCNNetNameResolver ipv4AddressesForName: nameToLookup) .
	self assert: allAddresses isCollection.	
	self deny: allAddresses isEmpty.
	self assert: (allAddresses anySatisfy:[:anAddress| anAddress ip = '212.103.66.211']).

]

{ #category : #'tests localhost' }
OCNIpv4NetNameResolverTest >> testLookupLocalhostIpv4Address [
	
	| localhostAddress |
	localhostAddress := '127.0.0.1'. "TO BE CHANGED TO an instance of Ipv4Address"
	
	#( 'localhost'  '127.0.0.1' ) do: [ :nameToLookup | 
		self assert: ((OCNNetNameResolver ipv4AddressForName: nameToLookup) isKindOf: OCNIpv4Address).
		self assert: (OCNNetNameResolver ipv4AddressForName: nameToLookup) ip  = localhostAddress.
	]

]

{ #category : #'tests localhost' }
OCNIpv4NetNameResolverTest >> testLookupLocalhostIpv4Addresses [
	
	|  allAddresses |
	allAddresses := (OCNNetNameResolver ipv4AddressesForName: 'localhost') .
	self assert: allAddresses isCollection.
	self deny: allAddresses isEmpty.
	
	"self assert: (allAddresses allSatisfy:  [ :ipAddress |  ipAddress isIpv4 ])"
	
]

{ #category : #'tests ipv4' }
OCNIpv4NetNameResolverTest >> testLookupUnknownNameIpv4Address [
	
	| nameToLookup address |
	
	nameToLookup := 'www.thatneverwillexistwebsite.org'.
	self should: [OCNNetNameResolver ipv4AddressForName: nameToLookup] raise: OCNNameLookupError.
	
]

{ #category : #'tests ipv4' }
OCNIpv4NetNameResolverTest >> testLookupUnknownNameIpv4Addresses [
	
	| nameToLookup |
	
	nameToLookup := 'www.thatneverwillexistwebsite.org'.
	self should: [OCNNetNameResolver ipv4AddressesForName: nameToLookup] raise: OCNNameLookupError.
	
]

{ #category : #'tests loopback' }
OCNIpv4NetNameResolverTest >> testLoopBackIpv4Address [
	
	self assert: (OCNNetNameResolver ipv4LoopBackAddress isKindOf: OCNIpv4Address).
	self assert: OCNNetNameResolver ipv4LoopBackAddress ip = '127.0.0.1'.
	self signalFailure: 'OCNIpAddress should NOT integrate port number'
]
