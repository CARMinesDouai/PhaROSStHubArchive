Class {
	#name : #OCNShellTest,
	#superclass : #TestCase,
	#instVars : [
		'shell'
	],
	#category : #'Ocean-Kernel-TestSupport'
}

{ #category : #'setUp-tearDown' }
OCNShellTest >> setUp [ 
	super setUp.
	shell := OCNShell new
]

{ #category : #testing }
OCNShellTest >> testExecutionDoesUsePath [
	shell exec: 'ls ', SmalltalkImage current imageName.
	shell waitForTermination.
	self assert: shell isTerminated.
	self assert: shell stdOut upToEnd withoutTrailingBlanks = SmalltalkImage current imageName.
]

{ #category : #testing }
OCNShellTest >> testExecutionTerminatesAndStdOutContainsExpectedResult [
	shell exec: '/bin/ls ', SmalltalkImage current imageName.
	shell waitForTermination.
	self assert: shell isTerminated.
	self assert: shell stdOut upToEnd withoutTrailingBlanks = SmalltalkImage current imageName.
]
