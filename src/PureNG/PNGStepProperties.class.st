Class {
	#name : #PNGStepProperties,
	#superclass : #Object,
	#instVars : [
		'motionType',
		'targetDistance',
		'traveledDistance',
		'status'
	],
	#category : #'PureNG-ServiceData'
}

{ #category : #status }
PNGStepProperties class >> complete [ 
	^ 1.
]

{ #category : #printing }
PNGStepProperties class >> motionDictionary [
	^ {
		self rotation -> 'rotation' .
		self stop -> 'stop'. 
		self translation -> 'translation'
	} asDictionary.
]

{ #category : #status }
PNGStepProperties class >> processing [
	^ 0.
]

{ #category : #'motion types' }
PNGStepProperties class >> rotation [
	^ 1
]

{ #category : #printing }
PNGStepProperties class >> statusDictionary [
	^ {
		self processing -> 'processing' .
		self complete -> 'complete'
	} asDictionary.
]

{ #category : #'motion types' }
PNGStepProperties class >> stop [
	^ 2
]

{ #category : #'motion types' }
PNGStepProperties class >> translation [
	^ 0
]

{ #category : #accessing }
PNGStepProperties >> motionLabel [
	^ PNGStepProperties motionDictionary at: self motionType.
]

{ #category : #'as yet unclassified' }
PNGStepProperties >> motionType [ 
	^ motionType.
]

{ #category : #'as yet unclassified' }
PNGStepProperties >> motionType: aMotionType [
	motionType := aMotionType.
]

{ #category : #accessing }
PNGStepProperties >> printOn: aStream [
	super printOn: aStream.
	aStream 
		cr;
		nextPutAll: 'status: ';
		nextPutAll: self statusLabel;
		cr;
		nextPutAll: 'distance covered: '.
	self traveledDistance printOn: aStream showingDecimalPlaces: 2.
	aStream 
		cr;
		nextPutAll: 'target distance: '.
	self targetDistance printOn: aStream showingDecimalPlaces: 2.
	aStream 
		cr;
		nextPutAll: 'motion type: ';
		nextPutAll: self motionLabel;
		cr.
		
]

{ #category : #accessing }
PNGStepProperties >> status [
	^ status
]

{ #category : #accessing }
PNGStepProperties >> status: anObject [
	status := anObject
]

{ #category : #accessing }
PNGStepProperties >> statusLabel [
	^ PNGStepProperties statusDictionary at: self status.
]

{ #category : #accessing }
PNGStepProperties >> targetDistance [
	^ targetDistance
]

{ #category : #accessing }
PNGStepProperties >> targetDistance: anObject [
	targetDistance := anObject
]

{ #category : #accessing }
PNGStepProperties >> traveledDistance [
	^ traveledDistance
]

{ #category : #accessing }
PNGStepProperties >> traveledDistance: anObject [
	traveledDistance := anObject
]
