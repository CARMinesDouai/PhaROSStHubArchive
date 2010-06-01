Class {
	#name : #OCNNetCatBasedServerTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Ocean-Kernel-TestSupport'
}

{ #category : #testing }
OCNNetCatBasedServerTest >> testDoubleStartDoesNotCreateExtraProcess [
	self fail
]

{ #category : #testing }
OCNNetCatBasedServerTest >> testDoubleStopDoesNotRaiseException [
	self fail
]

{ #category : #testing }
OCNNetCatBasedServerTest >> testStartRunsProcess [
	self fail
]

{ #category : #testing }
OCNNetCatBasedServerTest >> testStopKillsProcess [
	self fail
]
