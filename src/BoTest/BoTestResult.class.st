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

{ #category : #adding }
BoTestResult >> addFailingRequirement: testCase [
	requirementResultsDict at: testCase put: false
]

{ #category : #adding }
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
BoTestResult >> isPassed: aTestCase [
	^(super isPassed: aTestCase) or: [requirementResultsDict at: aTestCase ifAbsent: [false]]
]

{ #category : #testing }
BoTestResult >> isRun: aTestCase [
	^ (self passed includes: aTestCase)
		or: [ (self defects includes: aTestCase) or: [ 
				self isRunAsRequirement: aTestCase ] ]
]

{ #category : #testing }
BoTestResult >> isRunAsRequirement: aTestCase [
	^ requirementResultsDict keys includes: aTestCase
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
	(self isRunAsRequirement: aTestCase) ifTrue: [
		(requirementResultsDict at: aTestCase) ifTrue: [^self addPass: aTestCase].
		aTestCase hasFailingRequirement ifTrue: [^self].
		^self addFailure: aTestCase.
	].
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

{ #category : #running }
BoTestResult >> runRequiredCase: aTestCase [
	[
	aTestCase result: self.
	aTestCase runCase.
	self addPassingRequirement: aTestCase.
	]
		on: self class failure , Warning, self class error, BoRequirementFailureException
		do: [:ex | 
			self addFailingRequirement: aTestCase]
]

{ #category : #accessing }
BoTestResult >> testsWithFailingRequirements [
	^ testWithFailingRequirements
]

{ #category : #accessing }
BoTestResult >> testsWithFailingRequirementsCount [
	^self testsWithFailingRequirements size
]
