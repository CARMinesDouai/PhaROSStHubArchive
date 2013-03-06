"
Instance Variables:
	requirementFailures	<Set> test cases which have a requirement that is not satified
	requirementResultsDict	<Dictionary> results of tests that were run as requirements
"
Class {
	#name : #BoTestResult,
	#superclass : #TestResult,
	#instVars : [
		'requirementResultsDict',
		'testWithFailingRequirements'
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
BoTestResult >> addTestWithFailingRequirement: aTestCase [
	^self testsWithFailingRequirements add: aTestCase 
]

{ #category : #accessing }
BoTestResult >> defects [
	^super defects asSet, self testsWithFailingRequirements 
]

{ #category : #testing }
BoTestResult >> hasFailingRequirement: aTestCase [
	^self testsWithFailingRequirements includes: aTestCase
]

{ #category : #testing }
BoTestResult >> hasFailures [
	^super hasFailures or: [self testsWithFailingRequirementsCount > 0]
]

{ #category : #initialization }
BoTestResult >> initialize [
	super initialize.
	testWithFailingRequirements := Set new.
	requirementResultsDict := Dictionary new
]

{ #category : #testing }
BoTestResult >> isPassed: selector in: testCaseClass [
	| case |
	case := testCaseClass selector: selector.
	^(self passed includes: case) or: [requirementResultsDict at: case ifAbsent: [false]]
]

{ #category : #testing }
BoTestResult >> isRun: aSelector in: aTestCaseClass [

	| case |
	case := aTestCaseClass selector: aSelector.
	^(self passed includes: case) or:[
		(self defects includes: case) or:[
			requirementResultsDict keys includes: case.
			]
		]
]

{ #category : #printing }
BoTestResult >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: ', ';
		nextPutAll: self testsWithFailingRequirementsCount  printString;
		nextPutAll: ' failed requirements'
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
	^super runCount + self testsWithFailingRequirementsCount 
]

{ #category : #accessing }
BoTestResult >> testsWithFailingRequirements [
	^ testWithFailingRequirements
]

{ #category : #accessing }
BoTestResult >> testsWithFailingRequirementsCount [
	^self testsWithFailingRequirements size
]
