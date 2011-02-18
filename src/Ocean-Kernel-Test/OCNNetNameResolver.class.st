Class {
	#name : #OCNNetNameResolver,
	#superclass : #Object,
	#classVars : [
		'networkLibrary'
	],
	#category : #'Ocean-Kernel'
}

{ #category : #'name resolution' }
OCNNetNameResolver class >> ipv4AddressForName: nameToLookup [

	^ self networkLibrary ipv4AddressForName: nameToLookup   
]

{ #category : #'name resolution' }
OCNNetNameResolver class >> ipv4AddressesForName: nameToLookup [

	^ self networkLibrary ipv4AddressesForName: nameToLookup   
]

{ #category : #'name resolution' }
OCNNetNameResolver class >> ipv4LocalhostAddress [
	^self ipv4AddressForName: self loopBackName    
	
]

{ #category : #'name resolution' }
OCNNetNameResolver class >> ipv4LocalhostAddresses [
	|allAddresses|
	allAddresses := Set new.
	allAddresses addAll: (self ipv4AddressesForName: self loopBackName);
		addAll: (self ipv4AddressesForName: self localhostName).
	^allAddresses
	
]

{ #category : #'name resolution' }
OCNNetNameResolver class >> ipv6AddressForName: nameToLookup [

	^ self networkLibrary ipv6AddressForName: nameToLookup   
]

{ #category : #'name resolution' }
OCNNetNameResolver class >> ipv6AddressesForName: nameToLookup [

	^ self networkLibrary ipv6AddressesForName: nameToLookup   
]

{ #category : #'name resolution' }
OCNNetNameResolver class >> ipv6LocalhostAddress [
	^self ipv6AddressForName: self loopBackName    
	
]

{ #category : #'name resolution' }
OCNNetNameResolver class >> ipv6LocalhostAddresses [
	|allAddresses|
	allAddresses := Set new.
	allAddresses addAll: (self ipv6AddressesForName: self loopBackName);
		addAll: (self ipv6AddressesForName: self localhostName).
	^allAddresses
]

{ #category : #'name resolution' }
OCNNetNameResolver class >> localhostName [
	^self networkLibrary localhostName
]

{ #category : #'name resolution' }
OCNNetNameResolver class >> loopBackIpv4Address [
	^self ipv4AddressForName: self loopBackName   
]

{ #category : #'name resolution' }
OCNNetNameResolver class >> loopBackIpv6Address [
	^self ipv6AddressForName: self loopBackName   
]

{ #category : #'name resolution' }
OCNNetNameResolver class >> loopBackName [
	^'localhost'
]

{ #category : #accessing }
OCNNetNameResolver class >> networkLibrary [ 
	^ networkLibrary ifNil: [
		networkLibrary := OCNNetworkLibraryProxyFactory proxyForLibraryClass: OCNSocketPluginLibrary 
	]
]
