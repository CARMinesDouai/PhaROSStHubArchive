Class {
	#name : #OCNFileStdOutShellTest,
	#superclass : #TestCase,
	#instVars : [
		'shell'
	],
	#category : #'Ocean-Kernel-TestSupport'
}

{ #category : #'setUp-tearDown' }
OCNFileStdOutShellTest >> setUp [
	super setUp.
	shell := OCNFileStdOutShell onStdOutFileNamed: self stdOutFileNameAndPath
]

{ #category : #accessing }
OCNFileStdOutShellTest >> stdOutFileDir [
	^FileDirectory on: self stdOutFilePath.

]

{ #category : #accessing }
OCNFileStdOutShellTest >> stdOutFileName [
	^'toDelete-OCNFileStdOutShellTest.txt'
]

{ #category : #accessing }
OCNFileStdOutShellTest >> stdOutFileNameAndPath [
	^SmalltalkImage current imagePath,  
		FileDirectory pathNameDelimiter asString,  
		self stdOutFileName 
]

{ #category : #accessing }
OCNFileStdOutShellTest >> stdOutFilePath [
	^ FileDirectory dirPathFor: self stdOutFileNameAndPath
]

{ #category : #accessing }
OCNFileStdOutShellTest >> stdOutFileStream [
	^FileStream fileNamed: self stdOutFileNameAndPath
]

{ #category : #'setUp-tearDown' }
OCNFileStdOutShellTest >> tearDown [
	| stdOutFilePath stdOutFileDir |
	super tearDown.
	self stdOutFileDir deleteFileNamed: self stdOutFileName
]

{ #category : #testing }
OCNFileStdOutShellTest >> testDeleteStdOutFile [
	shell exec: 'ls'.
	shell waitForStop.
	self assert: (self stdOutFileDir fileExists: self stdOutFileName).
	shell deleteStdOutFile.
	self deny: (self stdOutFileDir fileExists: self stdOutFileName).

]

{ #category : #testing }
OCNFileStdOutShellTest >> testFileCreatedOnCommandExecution [
	self deny: (self stdOutFileDir fileExists: self stdOutFileName).
	shell exec: 'ls'.
	shell waitForStop.
	self assert: (self stdOutFileDir fileExists: self stdOutFileName).
	self assert: self stdOutFileStream size > 0 
]

{ #category : #testing }
OCNFileStdOutShellTest >> testFileRecreatedOnCommandExecution [
	| initialStdOutFileSize |
	shell exec: 'ls'.
	shell waitForStop.
	self assert: (self stdOutFileDir fileExists: self stdOutFileName).
	initialStdOutFileSize := self stdOutFileStream  size.
	shell exec: 'ls'.
	shell waitForStop.
	self assert: self stdOutFileStream size = initialStdOutFileSize
]
