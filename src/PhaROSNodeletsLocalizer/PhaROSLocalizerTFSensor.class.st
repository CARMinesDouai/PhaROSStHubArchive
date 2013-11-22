Class {
	#name : #PhaROSLocalizerTFSensor,
	#superclass : #Object,
	#instVars : [
		'callback',
		'process',
		'localizer',
		'robotFrame',
		'rate'
	],
	#category : #PhaROSNodeletsLocalizer
}

{ #category : #'as yet unclassified' }
PhaROSLocalizerTFSensor >> for: aCallback [	
	callback := aCallback.
	process := self paralellize looping pollDistances asStickyReference.
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerTFSensor >> initialize [ 
	rate := 2 hz.
	
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
		pose position module2d < 1.0 ifTrue: [
			callback cull: (PhaROSLocalizerMeasure id: entity id pose: pose) cull: self cull: DateAndTime now
		].] on: Error do: [ :e | self debug: e messageText ].
	].
	
	rate wait. 
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerTFSensor >> rate: aRate [
	rate := aRate.
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerTFSensor >> robotFrame: aRobotFrameID [
	robotFrame := aRobotFrameID.
]
