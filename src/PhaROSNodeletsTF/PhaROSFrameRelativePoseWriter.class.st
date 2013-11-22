Class {
	#name : #PhaROSFrameRelativePoseWriter,
	#superclass : #Object,
	#instVars : [
		'frame',
		'tfnodelet'
	],
	#category : #PhaROSNodeletsTF
}

{ #category : #'as yet unclassified' }
PhaROSFrameRelativePoseWriter class >> for: aFrame through: aNodelet [
	^ self new frame: aFrame; tfnodelet: aNodelet; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSFrameRelativePoseWriter >> asString [
	^ 'local-tf-writter'
]

{ #category : #'as yet unclassified' }
PhaROSFrameRelativePoseWriter >> frame: aFrame [
	frame := aFrame.
	frame broadcaster: self.
]

{ #category : #'as yet unclassified' }
PhaROSFrameRelativePoseWriter >> pose: aPhaROSPose [
	frame pose: aPhaROSPose. 
	frame stamp: DateAndTime now.
	
	tfnodelet tf: [ : aTfMessage |

		
		aTfMessage addTransform:  frame asTransformStamped.
		
	 ].


]

{ #category : #'as yet unclassified' }
PhaROSFrameRelativePoseWriter >> printOn: aStream [
	aStream nextPutAll: self asString.
]

{ #category : #'as yet unclassified' }
PhaROSFrameRelativePoseWriter >> tfnodelet: aNodelet [
	tfnodelet := aNodelet 
]
