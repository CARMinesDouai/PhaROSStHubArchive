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

	^self networkLibrary ipv4AddressesForName: nameToLookup
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
OCNNetNameResolver class >> ipv4LocalHostAddress [
	^self networkLibrary ipv4LocalHostAddress
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

{ #category : #'localhost resolution' }
OCNNetNameResolver class >> localHostAddresses [
	^self ipv4LocalHostAddresses.
	
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
