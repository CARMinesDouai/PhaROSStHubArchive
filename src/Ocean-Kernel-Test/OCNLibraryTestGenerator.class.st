Class {
	#name : #OCNLibraryTestGenerator,
	#superclass : #Object,
	#category : #'Ocean-Kernel-Test'
}

{ #category : #'as yet unclassified' }
OCNLibraryTestGenerator class >> generateForAllLibrary [
	"self  generateForAllLibrary"
	
	OCNNetworkLibraryProxyFactory allNetworkLibraryProxyClasses do: [ :aLibraryClass |
		self generateTestForLibrary: aLibraryClass
	]
]

{ #category : #'as yet unclassified' }
OCNLibraryTestGenerator class >> generateTestForLibrary: aLibraryClass [

	| generatedClasses |
	generatedClasses := self ocnTestClasses collect: [ :testClass | 
		testClass subclass: (aLibraryClass name, testClass name) asSymbol
			instanceVariableNames: '' classVariableNames: '' poolDictionaries: '' 
			category: 'Ocean-Tests-Generated-',aLibraryClass name
	].
	
	generatedClasses do: [ :testClass | 
		testClass compile: 'networkLibraryClass \^' withCRs, aLibraryClass name	.
		testClass class compile: 'isAbstract \^false' withCRs
	]


]

{ #category : #accessing }
OCNLibraryTestGenerator class >> ocnTestClasses [
	^{OCNTcpSocketReceivingDataTest. OCNTcpSocketSendingDataTest. OCNTcpSocketTest}
]