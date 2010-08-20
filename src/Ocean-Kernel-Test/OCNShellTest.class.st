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
OCNShellTest >> testExecutableRetrievedFromFullPath [
	
	self assert: (OCNShell new fullExecutablePath:'/bin/ls') = '/bin/ls'
]

{ #category : #testing }
OCNShellTest >> testExecutionDoesUsePathEnvironmentVariable [
	shell exec: 'ls ', SmalltalkImage current imageName.
	shell waitForStop.
	self assert: shell isStopped.
	self assert: shell stdOut upToEnd withoutTrailingBlanks = SmalltalkImage current imageName.
]

{ #category : #testing }
OCNShellTest >> testExecutionTerminatesAndStdOutContainsExpectedResult [
	shell exec: '/bin/ls ', SmalltalkImage current imageName.
	shell waitForStop.
	self assert: shell isStopped.
	self assert: shell stdOut upToEnd withoutTrailingBlanks = SmalltalkImage current imageName.
]

{ #category : #testing }
OCNShellTest >> testFullExecutablePathRetrieval [
	
	self assert: (OCNShell new fullExecutablePath:'ls') = '/bin/ls'
]

{ #category : #testing }
OCNShellTest >> testFullExecutablePathRetrievalFail [
	
	self assert: (OCNShell new fullExecutablePath:'lsNOTEXIST') = ''
]
