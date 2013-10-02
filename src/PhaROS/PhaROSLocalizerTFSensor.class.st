Class {
	#name : #PhaROSLocalizerTFSensor,
	#superclass : #Object,
	#instVars : [
		'callback',
		'process',
		'localizer',
		'robotFrame'
	],
	#category : #'PhaROS-Nodelets-Localizer'
}

{ #category : #'as yet unclassified' }
PhaROSLocalizerTFSensor >> for: aCallback [	
	callback := aCallback.
	process := self paralellize looping pollDistances asStickyReference.
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerTFSensor >> localizer: aLocalizerNodelet [
	localizer := aLocalizerNodelet.
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerTFSensor >> pollDistances [
	| pose |

	localizer scannedEntities do: [
		: entity |
		[
		pose := localizer nodelets transformation transformBetween: entity frameName and: robotFrame.
		pose position module2d < 2.0 ifTrue: [
			callback cull: (PhaROSLocalizerMeasure id: entity id pose: pose) cull: self cull: DateAndTime now
		].] on: Error do: [ :e | Transcript show:e messageText ; cr ].
	].

]

{ #category : #'as yet unclassified' }
PhaROSLocalizerTFSensor >> robotFrame: aRobotFrameID [
	robotFrame := aRobotFrameID.
]
