Class {
	#name : #PhaROSFrameRelativePoseWriter,
	#superclass : #Object,
	#instVars : [
		'frame',
		'tfnodelet'
	],
	#category : #'PhaROS-Nodelets-TF'
}

{ #category : #'as yet unclassified' }
PhaROSFrameRelativePoseWriter class >> for: aFrame through: aNodelet [
	^ self new frame: aFrame; tfnodelet: aNodelet; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSFrameRelativePoseWriter >> frame: aFrame [
	frame := aFrame
		
]

{ #category : #'as yet unclassified' }
PhaROSFrameRelativePoseWriter >> pose: aPhaROSPose [
	frame pose: aPhaROSPose. 
	
	tfnodelet tf: [ : aTfMessage |

		
		aTfMessage addTransform:  frame asTransformStamped.
		
	 ].


]

{ #category : #'as yet unclassified' }
PhaROSFrameRelativePoseWriter >> tfnodelet: aNodelet [
	tfnodelet := aNodelet 
]
