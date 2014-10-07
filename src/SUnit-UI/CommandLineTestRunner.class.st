"
I am command line test runner. I run a TestSuite and outpout the progress in a terminal friendly way.
"
Class {
	#name : #CommandLineTestRunner,
	#superclass : #HDTestReport,
	#instVars : [
		'stderr',
		'stdout',
		'currentTest',
		'maxTest',
		'shouldSerializeError'
	],
	#category : #'SUnit-UI'
}

{ #category : #running }
CommandLineTestRunner >> done [
	
]

{ #category : #helper }
CommandLineTestRunner >> handleFailure: anError of: aTestCase [ 
	self printFailure: anError of: aTestCase.
	self shouldSerializeError 
		ifTrue: [ self serializeError: anError of: aTestCase ]
]

{ #category : #helper }
CommandLineTestRunner >> handleSkip: aTestSkip of: aTestCase [ 

	self
		print: aTestSkip printString 
		short: ' [SKIPPED]' 
		of: aTestCase
]

{ #category : #helper }
CommandLineTestRunner >> increaseTestCount [
	currentTest := currentTest + 1.
]

{ #category : #initialization }
CommandLineTestRunner >> initialize [
	super initialize.
	shouldSerializeError := false.
]

{ #category : #helper }
CommandLineTestRunner >> print: anLongErrorMesssage short: aShortString of: aTestCase [ 
	| testCaseString offset |
	testCaseString := aTestCase printString.
	
	self stdout 
		startOfLine; clearToEnd; nextPutAll: testCaseString.
	
	"Let's see if we have enough space to print the error"
	offset := 80 - testCaseString size - anLongErrorMesssage size.
	offset < 1
		ifTrue: [ 
			self stdout startOfLine; right: (80 - aShortString size); 
				nextPutAll: aShortString ]
		ifFalse: [ 
			self stdout right: offset;
				nextPutAll: anLongErrorMesssage ].
		
	self stdout
		clear; lf.
]

{ #category : #helper }
CommandLineTestRunner >> printFailure: anError of: aTestCase [ 
	self stderr red.
	self
		print: anError printString 
		short: ' [FAIL]' 
		of: aTestCase 
]

{ #category : #printing }
CommandLineTestRunner >> printProgress [
	| string |
	string := '[',currentTest asString, '/', maxTest asString,']'.
	self stderr 
		startOfLine; right: (80 - string size); nextPutAll: string.
]

{ #category : #printing }
CommandLineTestRunner >> printReport [
	self stderr lf; 
		nextPutAll: 'Finished running '; print: maxTest; 
		nextPutAll: ' Test'; nextPutAll: (maxTest = 1 ifTrue: [''] ifFalse: ['s']); lf
]

{ #category : #printing }
CommandLineTestRunner >> printTestCase: aTestCase [ 
	self stderr 
		startOfLine; clearToEnd; green; 
		print: aTestCase; clear.
	self printProgress.
]

{ #category : #running }
CommandLineTestRunner >> runCase: aTestCase [
	self increaseTestCount.
	self printTestCase: aTestCase.
	
	[[ aTestCase runCase ] 
		on: Halt , Error, TestFailure
		do: [ :err | self handleFailure: err of: aTestCase ]]
		on: TestSkip do: [ :skip| self handleSkip: skip of: aTestCase ]
]

{ #category : #running }
CommandLineTestRunner >> setUp [
	
	currentTest := 0.
	maxTest := suite tests size.
]

{ #category : #accessing }
CommandLineTestRunner >> shouldSerializeError [
	^ shouldSerializeError
]

{ #category : #accessing }
CommandLineTestRunner >> shouldSerializeError: aBoolean [
	shouldSerializeError := aBoolean.
]

{ #category : #accessing }
CommandLineTestRunner >> stderr [
	(stderr isNil or: [ stderr closed ])
		ifTrue: [ stderr := VTermOutputDriver stderr ].
	^ stderr 
]

{ #category : #accessing }
CommandLineTestRunner >> stdout [
	(stdout isNil or: [ stdout closed ])
		ifTrue: [ stdout := VTermOutputDriver stdout ].
		
	^ stdout
]

{ #category : #running }
CommandLineTestRunner >> tearDown [
	self printReport
]
