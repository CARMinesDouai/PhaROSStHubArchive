"
an OCNSocket has the following lifecycle :
 
state 1 : closed
state 2 : connected
state 3 : listening
state 4 : destroyed

1 -> 2, 3, 4
2 -> 1
3 -> 1

"
Class {
	#name : #OCNSocket,
	#superclass : #Object,
	#instVars : [
		'socketId',
		'networkLibrary',
		'state'
	],
	#category : #'Ocean-Kernel'
}

{ #category : #'instance creation' }
OCNSocket class >> newWithNetworkLibrary: aNetworkLibraryProxy [
	^super new
		networkLibrary: aNetworkLibraryProxy;
		yourself
]

{ #category : #'initialize-release' }
OCNSocket >> initialize [ 
	super initialize.
	self networkLibrary: OCNNetworkLibraryProxyFactory networkLibraryProxy.
	self socketId: self newSocketId.
	self state: #undefined
]

{ #category : #accessing }
OCNSocket >> networkLibrary [
	^ networkLibrary
]

{ #category : #accessing }
OCNSocket >> networkLibrary: anObject [
	networkLibrary := anObject
]

{ #category : #'initialize-release' }
OCNSocket >> newSocketId [
	self subclassResponsibility 
]

{ #category : #accessing }
OCNSocket >> socketId [
	^ socketId
]

{ #category : #accessing }
OCNSocket >> socketId: anObject [
	socketId := anObject
]

{ #category : #accessing }
OCNSocket >> state [
	^ state
]

{ #category : #private }
OCNSocket >> state: anObject [
	state := anObject
]
