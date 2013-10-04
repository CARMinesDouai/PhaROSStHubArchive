Class {
	#name : #SGStandAloneMode,
	#superclass : #Object,
	#instVars : [
		'callback',
		'zero',
		'lastLandmarkMeasure'
	],
	#category : #'StarGazer-Kernel'
}

{ #category : #'as yet unclassified' }
SGStandAloneMode >> callback: aCallbackForMeasures [
	callback := aCallbackForMeasures.
]

{ #category : #'as yet unclassified' }
SGStandAloneMode >> trustableMeasure: aLandmark [
	| diffPose |
	
	^lastLandmarkMeasure isNil or: [ 
		lastLandmarkMeasure id = aLandmark id 
		and: [
			diffPose := lastLandmarkMeasure pose - aLandmark pose.
			diffPose position module2d < StarGazer differentialPositionThreshold and: [
				diffPose orientation abs < StarGazer differentialRotationThreshold.
			].
		].
	].
]

{ #category : #'as yet unclassified' }
SGStandAloneMode >> updateWorld: aLandmark [
	self halt.
	" In order to reduce the error of measurements of phantom landmarks, we ask for at least two measures of the same id "
	[
		(self trustableMeasure: aLandmark ) ifTrue:[
			callback value: aLandmark.
		].
	] ensure: [
		lastLandmarkMeasure := aLandmark.
	]
]
