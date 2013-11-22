Class {
	#name : #PhaROSTransformationTests,
	#superclass : #TestCase,
	#instVars : [
		'browser'
	],
	#category : #'PhaROSTest-Util'
}

{ #category : #'as yet unclassified' }
PhaROSTransformationTests >> testNormalizeFrame [
	self assert: '/frame' normalizeFrame = 'frame'.
	self assert: 'frame' normalizeFrame = 'frame'.
	self assert: 'frame/frame' normalizeFrame = 'frame/frame'.
	self assert: '/frame/frame' normalizeFrame = 'frame/frame'.
]
