Class {
	#name : #PhaROSTransformationDataBase,
	#superclass : #Object,
	#instVars : [
		'frames',
		'interested'
	],
	#category : #'PhaROS-Packages-TF'
}

{ #category : #'as yet unclassified' }
PhaROSTransformationDataBase >> at: aFrameID [
	^ frames at: aFrameID ifAbsentPut: [ PhaROSTFFrame id: aFrameID ]
]

{ #category : #'as yet unclassified' }
PhaROSTransformationDataBase >> initialize [ 
	frames := Dictionary new.
	interested := OrderedCollection new. 
	
]

{ #category : #'as yet unclassified' }
PhaROSTransformationDataBase >> process: aTFMessage [ 
	
	aTFMessage transforms do: [ : t | (self at: t child_frame_id ) updateFrom: t using: self ].
	
	interested do: [ :it | (it at:1 )value: (it at:2) value].
]

{ #category : #'as yet unclassified' }
PhaROSTransformationDataBase >> pseudoTopicBetween:  aFrameID and: anOtherFrameID for: aCallback [
	^ self register: aCallback for: [  (self at: aFrameID) poseRelativeTo: (self at: anOtherFrameID) ].
	
]

{ #category : #'as yet unclassified' }
PhaROSTransformationDataBase >> register: aCallback for: aPoseCalculator [
	interested add: { aCallback . aPoseCalculator }
	
]
