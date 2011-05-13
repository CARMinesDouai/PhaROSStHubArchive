Class {
	#name : #OCNNetNameResolver,
	#superclass : #Object,
	#classVars : [
		'networkLibrary'
	],
	#category : #'Ocean-Kernel'
}

{ #category : #'name resolution' }
OCNNetNameResolver class >> addressesForName: nameToLookup [

	^Set new
		addAll: (self networkLibrary ipv4AddressesForName: nameToLookup) ;
		addAll: (self networkLibrary ipv6AddressesForName: nameToLookup) ;
		yourself
]

{ #category : #'name resolution' }
OCNNetNameResolver class >> ipv4AddressForName: nameToLookup [

	^ self networkLibrary ipv4AddressForName: nameToLookup   
]

{ #category : #'name resolution' }
OCNNetNameResolver class >> ipv4AddressesForName: nameToLookup [

	^ self networkLibrary ipv4AddressesForName: nameToLookup   
]

{ #category : #'localhost resolution' }
OCNNetNameResolver class >> ipv4LocalHostAddresses [
	|allAddresses|
	allAddresses := Set new.
	allAddresses addAll: (self ipv4AddressesForName: self loopBackName);
		addAll: (self ipv4AddressesForName: self localHostName).
	^allAddresses
	
]

{ #category : #'loopback resolution' }
OCNNetNameResolver class >> ipv4LoopBackAddress [
	^self ipv4AddressForName: self loopBackName    
	
]

{ #category : #'name resolution' }
OCNNetNameResolver class >> ipv6AddressForName: nameToLookup [

	^ self networkLibrary ipv6AddressForName: nameToLookup   
]

{ #category : #'name resolution' }
OCNNetNameResolver class >> ipv6AddressesForName: nameToLookup [

	^ self networkLibrary ipv6AddressesForName: nameToLookup   
]

{ #category : #'localhost resolution' }
OCNNetNameResolver class >> ipv6LocalHostAddresses [
	^ #()
	"|allAddresses|
	allAddresses := Set new.
	allAddresses addAll: (self ipv6AddressesForName: self loopBackName);
		addAll: (self ipv6AddressesForName: self localHostName).
	^allAddresses"
]

{ #category : #'loopback resolution' }
OCNNetNameResolver class >> ipv6LoopBackAddress [
	^self ipv6AddressForName: self loopBackName    
	
]

{ #category : #'localhost resolution' }
OCNNetNameResolver class >> localHostAddresses [
	|allAddresses|
	allAddresses := self ipv4LocalHostAddresses.
	allAddresses addAll: self ipv6LocalHostAddresses.
	^allAddresses
	
]

{ #category : #'localhost resolution' }
OCNNetNameResolver class >> localHostName [
	^self networkLibrary localHostName
]

{ #category : #'loopback resolution' }
OCNNetNameResolver class >> loopBackAddresses [
	^self addressesForName: self loopBackName
]

{ #category : #'loopback resolution' }
OCNNetNameResolver class >> loopBackName [
	^'localhost'
]

{ #category : #accessing }
OCNNetNameResolver class >> networkLibrary [ 
	^ networkLibrary ifNil: [
		networkLibrary := OCNNetworkLibraryProxyFactory proxyForLibraryClass: OCNSocketPluginLibrary 
	]
]
