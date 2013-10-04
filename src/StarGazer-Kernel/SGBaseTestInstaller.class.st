Class {
	#name : #SGBaseTestInstaller,
	#superclass : #Object,
	#category : #'StarGazer-Kernel-Test-Trait'
}

{ #category : #'as yet unclassified' }
SGBaseTestInstaller class >> installAll: aTrait [
	self installAsSGDependant: aTrait.
	self installAsMockDependant: aTrait.
]

{ #category : #'as yet unclassified' }
SGBaseTestInstaller class >> installAsMockDependant: aTrait [
	Smalltalk at: ( (aTrait name copyReplaceAll: 'Trait' with: ''), 'MockDependant') asSymbol ifAbsent: [
		SGTestCaseMock subclass: ( (aTrait name copyReplaceAll: 'Trait' with: ''), 'MockDependant') asSymbol
		uses: aTrait
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: 'StarGazer-Kernel-Test'
	 ].
	
]

{ #category : #'as yet unclassified' }
SGBaseTestInstaller class >> installAsSGDependant: aTrait [
	Smalltalk at: ( (aTrait name copyReplaceAll: 'Trait' with: ''), 'SGDependant') asSymbol ifAbsent: [
		SGTestCaseDeviceDependant subclass:( (aTrait name copyReplaceAll: 'Trait' with: ''), 'SGDependant') asSymbol
		uses: aTrait
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: 'StarGazer-Kernel-Test'
	]
]
