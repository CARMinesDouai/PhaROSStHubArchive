Class {
	#name : #PhaROSPoseToTFNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'writer',
		'frame'
	],
	#category : #PhaROSNodeletsTF
}

{ #category : #'as yet unclassified' }
PhaROSPoseToTFNodelet >> express: aPoseTopic as: aFrame [
	writer at: aPoseTopic ifAbsentPut: [self nodelets transformation writerFor: aFrame].
	
	aPoseTopic for: [ : pose |  self log: 'receiving pose'. (self writerAt: aPoseTopic ) pose: pose ].
	
	
]

{ #category : #'as yet unclassified' }
PhaROSPoseToTFNodelet >> express: aPoseTopic as: aFrameID childOf: aParentFrameID [

	writer at: aPoseTopic ifAbsentPut: [ 
		| newWriter  |
		newWriter := (self nodelets transformation writerFor: aFrameID  withParent:  aParentFrameID ) .
		newWriter pose: PhaROSPose zero.
		newWriter.
	].

	aPoseTopic for: [ : pose | 
		(self writerAt: aPoseTopic) pose: pose 
	].
	
	
]

{ #category : #'as yet unclassified' }
PhaROSPoseToTFNodelet >> initialize [
	writer := Dictionary new

]

{ #category : #'as yet unclassified' }
PhaROSPoseToTFNodelet >> writer [
	^ writer
]

{ #category : #'as yet unclassified' }
PhaROSPoseToTFNodelet >> writerAt: aPoseTopic [ 
	^ writer at: aPoseTopic. 
]
