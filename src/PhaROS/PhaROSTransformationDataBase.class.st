Class {
	#name : #PhaROSTransformationDataBase,
	#superclass : #Object,
	#instVars : [
		'frames'
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
]

{ #category : #'as yet unclassified' }
PhaROSTransformationDataBase >> process: aTFMessage [ 
	self halt.
	Transcript show: aTFMessage ; cr. 
	aTFMessage transforms do: [ : t | (self at: t child_frame_id ) updateFrom: t using: self ].
	
]
