Class {
	#name : #PhaROSPoseToTFNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'writer',
		'frame'
	],
	#category : #'PhaROS-Nodelets-TF'
}

{ #category : #'as yet unclassified' }
PhaROSPoseToTFNodelet >> express: aPoseTopic as: aFrame [
	self writer: (self nodelets transformation writerFor: aFrame). 
	
	aPoseTopic for: [ : pose | self writer pose: pose ].
	
	
]

{ #category : #'as yet unclassified' }
PhaROSPoseToTFNodelet >> express: aPoseTopic as: aFrameID childOf: aParentFrameID [
	self writer: (self nodelets transformation writerFor: aFrameID  withParent:  aParentFrameID ). 
	aPoseTopic for: [ : pose | self writer pose: pose ].
	
	
]

{ #category : #'as yet unclassified' }
PhaROSPoseToTFNodelet >> writer [
	^ writer
]

{ #category : #'as yet unclassified' }
PhaROSPoseToTFNodelet >> writer: aFrameWriter [
	writer := aFrameWriter 
]
