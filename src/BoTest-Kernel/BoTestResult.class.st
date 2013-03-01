Class {
	#name : #BoTestResult,
	#superclass : #TestResult,
	#instVars : [
		'requirementFailures'
	],
	#category : #'BoTest-Kernel'
}

{ #category : #adding }
BoTestResult >> addRequirementFailure: aTestCase [
	^self requirementFailures add: aTestCase 
]

{ #category : #accessing }
BoTestResult >> failures [
	^super failures, self requirementFailures
]

{ #category : #initialization }
BoTestResult >> initialize [
	super initialize.
	requirementFailures := OrderedCollection new.

]

{ #category : #testing }
BoTestResult >> isPassed: selector in: testCaseClass [
	^self passed includes: (testCaseClass selector: selector)
]

{ #category : #testing }
BoTestResult >> isRun: selector in: testCaseClass [
	^self runs includes: (testCaseClass selector: selector)
]

{ #category : #printing }
BoTestResult >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: ', ';
		nextPutAll: self requirementFailuresCount  printString;
		nextPutAll: ' failed requirements'
]

{ #category : #accessing }
BoTestResult >> requirementFailures [
	^ requirementFailures
]

{ #category : #accessing }
BoTestResult >> requirementFailuresCount [
	^self requirementFailures size
]

{ #category : #accessing }
BoTestResult >> runs [
	^self defects, self passed
]
