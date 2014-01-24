Class {
	#name : #TKTTestVariable,
	#superclass : #TestCase,
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #'as yet unclassified' }
TKTTestVariable >> testApply [
	| variable |
	
	variable := TKTExclusiveAccessVariable initialValue: 1.
	
	self assert: (variable apply: [ : val | val + 2 ]) = 3
]

{ #category : #'as yet unclassified' }
TKTTestVariable >> testDoesnotUnderstandForwarding [
	| variable |
	
	variable := TKTExclusiveAccessVariable initialValue: 1.
	
	self assert: (variable + 2 ) = 3.
	 self assert: (variable < 2 ) .
]

{ #category : #'as yet unclassified' }
TKTTestVariable >> testGetSet [
	| variable |
	
	variable := TKTExclusiveAccessVariable initialValue: 1.
	
	self assert: variable value = 1.
	self assert: variable get = 1.
	
	variable set: [ 2 + 3 ].
	
	self assert: variable value = 5. 
]

{ #category : #'as yet unclassified' }
TKTTestVariable >> testValue [
	| variable |
	
	variable := TKTExclusiveAccessVariable initialValue: 1.
	
	self assert: variable value = 1.
	variable := TKTExclusiveAccessVariable initialValue: [ 3 + 2 ].
	self assert: variable value = 5. 
]
