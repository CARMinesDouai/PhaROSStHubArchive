Class {
	#name : #OCNSysSocketLibraryTest,
	#superclass : #TestCase,
	#category : #'Ocean-Kernel-Test'
}

{ #category : #testing }
OCNSysSocketLibraryTest >> testCallingHtons [
	| port encodedPort |
	port := 80.
	encodedPort := OCNNetworkLibraryProxyFactory networkLibraryProxy htons: port.
	self assert: port = 80 & (encodedPort = 20480)
]

{ #category : #testing }
OCNSysSocketLibraryTest >> testCallingNtohs [
	| port encodedPort |
	port := 20480.
	encodedPort := OCNNetworkLibraryProxyFactory networkLibraryProxy ntohs: port.
	self assert: encodedPort = 80 & (port = 20480)
]
