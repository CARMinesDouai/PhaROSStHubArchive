"
Instance Variables:
	requirementFailures	<Set> test cases which have a requirement that is not satified
	requirementResultsDict	<Dictionary> results of tests that were run as requirements
"
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

{ #category : #testing }
BoTestResult >> hasFailures [
	^super hasFailures or: [self requirementFailuresCount > 0]
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

{ #category : #running }
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
BoTestResult >> runCount [
	^super runCount + self requirementFailuresCount 
]
