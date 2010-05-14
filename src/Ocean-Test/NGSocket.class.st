Class {
	#name : #NGSocket,
	#superclass : #Object,
	#instVars : [
		'socketId',
		'isConnected'
	],
	#category : #'Ocean-Kernel'
}

{ #category : #connection }
NGSocket >> connectToServer: serverAddress [
	| result primitiveAddress |
	primitiveAddress := serverAddress primitiveAddress.
	result := SysSocketLibrary uniqueInstance 
		connect: self socketId serverAddress: primitiveAddress serverAddressSize: serverAddress primitiveAddressSize.
	primitiveAddress free.
	(result signedLongAt: 1) = 0 
		ifTrue: [self isConnected: true]
		ifFalse: [self isConnected: false]
]

{ #category : #'lowlevel initialization' }
NGSocket >> createDescriptorWithDomain: communicationDomain type: socketType protocol: socketProtocol [
	| result |
	result := DebugSysSocketLibrary uniqueInstance 
		socketDomain: communicationDomain type: socketType protocol: socketProtocol.
	self socketId: (result signedLongAt: 1)
]

{ #category : #'initialize-release' }
NGSocket >> initialize [ 
	super initialize.
	self isConnected: false
]

{ #category : #testing }
NGSocket >> isConnected [ 
	^isConnected
]

{ #category : #testing }
NGSocket >> isConnected: aBoolean [ 
	isConnected := aBoolean 
]

{ #category : #testing }
NGSocket >> isDescriptorCreated [
	self socketId ifNil: [^false].
	^self socketId ~= -1
]

{ #category : #accessing }
NGSocket >> socketId [
	^ socketId
]

{ #category : #accessing }
NGSocket >> socketId: anObject [
	socketId := anObject
]
