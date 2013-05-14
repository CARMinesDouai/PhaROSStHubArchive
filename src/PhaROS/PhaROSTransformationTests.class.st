Class {
	#name : #PhaROSTransformationTests,
	#superclass : #TestCase,
	#instVars : [
		'browser'
	],
	#category : #'PhaROS-Util-Test'
}

{ #category : #'as yet unclassified' }
PhaROSTransformationTests >> testNormalizeFrame [
	self assert: '/frame' normalizeFrame = 'frame'.
	self assert: 'frame' normalizeFrame = 'frame'.
	self assert: 'frame/frame' normalizeFrame = 'frame/frame'.
	self assert: '/frame/frame' normalizeFrame = 'frame/frame'.
]
