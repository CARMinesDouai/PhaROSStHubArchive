Class {
	#name : #OCNPosixLibraryTest,
	#superclass : #TestCase,
	#instVars : [
		'networkLibrary'
	],
	#category : #'Ocean-Kernel-Test'
}

{ #category : #accessing }
OCNPosixLibraryTest >> networkLibrary [
	^ networkLibrary
]

{ #category : #accessing }
OCNPosixLibraryTest >> networkLibrary: anObject [
	networkLibrary := anObject
]

{ #category : #'setUp-tearDown' }
OCNPosixLibraryTest >> posixLibraryClass [
	SmalltalkImage current platformName =  'Mac OS' ifTrue: [
	 ^ OCNMacOSXPosixLibrary ].
	^self error: 'Platform not supported yet'
]

{ #category : #'setUp-tearDown' }
OCNPosixLibraryTest >> setUp [
	networkLibrary := self posixLibraryClass new. 
]

{ #category : #testing }
OCNPosixLibraryTest >> testCallingHtons [
	| port encodedPort |
	port := 80.
	encodedPort := self networkLibrary htons: port.
	self assert: port = 80 & (encodedPort = 20480)
]

{ #category : #testing }
OCNPosixLibraryTest >> testCallingNtohs [
	| port encodedPort |
	port := 20480.
	encodedPort := self networkLibrary ntohs: port.
	self assert: encodedPort = 80 & (port = 20480)
]
