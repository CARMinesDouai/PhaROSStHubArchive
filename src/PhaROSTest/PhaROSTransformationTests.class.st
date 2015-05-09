Class {
	#name : #PhaROSTransformationTests,
	#superclass : #TestCase,
	#instVars : [
		'browser'
	],
	#category : #'PhaROSTest-Util'
}

{ #category : #tests }
PhaROSTransformationTests >> testNormalizeFrame [
	self assert: '/frame' normalizeFrame = 'frame'.
	self assert: 'frame' normalizeFrame = 'frame'.
	self assert: 'frame/frame' normalizeFrame = 'frame/frame'.
	self assert: '/frame/frame' normalizeFrame = 'frame/frame'.
]
