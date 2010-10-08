Class {
	#name : #OCNSocket,
	#superclass : #Object,
	#instVars : [
		'networkLibrary'
	],
	#category : #'Ocean-Kernel'
}

{ #category : #'instance creation' }
OCNSocket class >> new [
	^self newWithNetworkLibrary: OCNNetworkLibraryProxyFactory networkLibraryProxy 
	
]

{ #category : #'instance creation' }
OCNSocket class >> newWithNetworkLibrary: aNetworkLibraryProxy [
	^super new
		networkLibrary: aNetworkLibraryProxy;
		yourself
]

{ #category : #accessing }
OCNSocket >> networkLibrary [
	^ networkLibrary
]

{ #category : #accessing }
OCNSocket >> networkLibrary: anObject [
	networkLibrary := anObject
]
