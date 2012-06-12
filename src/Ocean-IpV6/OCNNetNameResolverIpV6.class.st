Class {
	#name : #OCNNetNameResolverIpV6,
	#superclass : #OCNNetNameResolver,
	#category : #'Ocean-IpV6'
}

{ #category : #'name resolution' }
OCNNetNameResolverIpV6 class >> addressesForName: nameToLookup [

	^Set new
		addAll: (super addressesForName: nameToLookup) ;
		addAll: (self networkLibrary ipv6AddressesForName: nameToLookup) ;
		yourself
]

{ #category : #'name resolution' }
OCNNetNameResolverIpV6 class >> ipv6AddressForName: nameToLookup [
	^ self networkLibrary ipv6AddressForName: nameToLookup   
]

{ #category : #'name resolution' }
OCNNetNameResolverIpV6 class >> ipv6AddressesForName: nameToLookup [

	^ self networkLibrary ipv6AddressesForName: nameToLookup   
]

{ #category : #'localhost resolution' }
OCNNetNameResolverIpV6 class >> ipv6LocalHostAddresses [

	|allAddresses|
	allAddresses := Set new.
	allAddresses addAll: (self ipv6AddressesForName: self loopBackName);
		addAll: (self ipv6AddressesForName: self localHostName).
	^allAddresses
]

{ #category : #'loopback resolution' }
OCNNetNameResolverIpV6 class >> ipv6LoopBackAddress [
	^self ipv6AddressForName: self loopBackName    
	
]

{ #category : #'localhost resolution' }
OCNNetNameResolverIpV6 class >> localHostAddresses [
	|allAddresses|
	allAddresses := super localHostAddresses.
	allAddresses addAll: self ipv6LocalHostAddresses.
	^allAddresses
	
]
