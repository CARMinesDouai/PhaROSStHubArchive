Class {
	#name : #BoTestResult,
	#superclass : #TestResult,
	#instVars : [
		'requirementFailures',
		'requirementResultsDict'
	],
	#category : #'BoTest-Kernel'
}

{ #category : #accessing }
BoTestResult >> addFailingRequirement: testCase [
	requirementResultsDict at: testCase put: false
]

{ #category : #accessing }
BoTestResult >> addPassingRequirement: testCase [
	requirementResultsDict at: testCase put: true
]

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
	requirementFailures := Set new.
	requirementResultsDict := Dictionary new
]

{ #category : #testing }
BoTestResult >> isPassed: selector in: testCaseClass [
	| case |
	case := testCaseClass selector: selector.
	^(self passed includes: case) or: [requirementResultsDict at: case ifAbsent: [false]]
]

{ #category : #testing }
BoTestResult >> isRequirementFailure: aTestCase [
	^self requirementFailures includes: aTestCase
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

{ #category : #'as yet unclassified' }
BoTestResult >> runCase: aTestCase [
	[
	aTestCase announce: TestCaseStarted withResult: self.
	aTestCase runCase.
	aTestCase announce: TestCaseEnded  withResult: self.
	self addPass: aTestCase]
		on: self class failure , Warning, self class error, BoRequirementFailureException
		do: [:ex | ex sunitAnnounce: aTestCase toResult: self]
]

{ #category : #accessing }
BoTestResult >> runs [
	^self defects, self passed
]
