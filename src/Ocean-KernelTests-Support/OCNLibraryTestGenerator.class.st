Class {
	#name : #OCNLibraryTestGenerator,
	#superclass : #Object,
	#category : #'Ocean-KernelTests'
}

{ #category : #generating }
OCNLibraryTestGenerator class >> categoryNameForLibrary: aLibraryClass [
	^aLibraryClass category asString, 'Tests-Generated'
]

{ #category : #generating }
OCNLibraryTestGenerator class >> generateForAllLibrary [
	"self  generateForAllLibrary"
			
	OCNNetworkLibraryProxyFactory allNetworkLibraryProxyClasses do: [ :aLibraryClass |
		self removeTestsForLibrary: aLibraryClass.
		self generateTestForLibrary: aLibraryClass
	]
]

{ #category : #generating }
OCNLibraryTestGenerator class >> generateTestForLibrary: aLibraryClass [

	| generatedClasses |
	aLibraryClass ifNil: [^self].
	generatedClasses := self ocnTestClasses collect: [ :testClass | 
		testClass subclass: (aLibraryClass name, testClass name) asSymbol
			instanceVariableNames: '' classVariableNames: '' poolDictionaries: '' 
			category: (self categoryNameForLibrary: aLibraryClass)
	].
	
	generatedClasses do: [ :testClass | 
		testClass compile: 'networkLibraryClass \^' withCRs, aLibraryClass name	.
		testClass class compile: 'isAbstract \^false' withCRs
	]


]

{ #category : #accessing }
OCNLibraryTestGenerator class >> ocnTestClasses [
	^OCNSocketTest  allSubclasses select: [ :testClass | testClass shouldBeSubclassedForBackendTesting].
	
	"{OCNTcpSocketReceivingDataTest. OCNTcpSocketSendingDataTest. OCNTcpSocketTest. OCNUdpSocketTest. OCNUdpSocketSendingDataTest. OCNUdpSocketReceivingDataTest. OCNTcpSocketFailureTest. OCNConversationTcpSocketFinalizationTest}"
]

{ #category : #generating }
OCNLibraryTestGenerator class >> removeTestsForLibrary: aLibraryClass [

	SystemOrganization removeSystemCategory:  (self categoryNameForLibrary: aLibraryClass)
]
