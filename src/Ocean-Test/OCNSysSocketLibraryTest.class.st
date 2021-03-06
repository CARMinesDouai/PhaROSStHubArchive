Class {
	#name : #OCNSysSocketLibraryTest,
	#superclass : #TestCase,
	#category : #'Ocean-Test'
}

{ #category : #testing }
OCNSysSocketLibraryTest >> testCallingHtons [
	
	| port encodedPort |
	port := 80.
	encodedPort := OCNKernel socketLibrary htons: port.
	self assert: ((port = 80) & (encodedPort = 20480))
]

{ #category : #testing }
OCNSysSocketLibraryTest >> testCallingNtohs [
	
	| port encodedPort |
	port := 20480.
	encodedPort := OCNKernel socketLibrary ntohs: port.
	self assert: ((encodedPort = 80) & (port = 20480))
]
