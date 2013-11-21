Class {
	#name : #PhaROSSensorMultiplexor,
	#superclass : #Object,
	#instVars : [
		'sensors',
		'tolerance',
		'callback',
		'reuseValues'
	],
	#category : #'PhaROS-Util-Sensor'
}

{ #category : #'as yet unclassified' }
PhaROSSensorMultiplexor >> callback [ 
	^ callback
]

{ #category : #'as yet unclassified' }
PhaROSSensorMultiplexor >> doNotReuseValues [
	reuseValues := false
]

{ #category : #'as yet unclassified' }
PhaROSSensorMultiplexor >> for: aCallback [
	callback := aCallback
]

{ #category : #'as yet unclassified' }
PhaROSSensorMultiplexor >> infinityTolerance [ 
	self tolerance: Float infinity
]

{ #category : #'as yet unclassified' }
PhaROSSensorMultiplexor >> mainteinance [ 
	reuseValues ifFalse: [
		sensors do:#releaseValue .
	]
]

{ #category : #'as yet unclassified' }
PhaROSSensorMultiplexor >> reuseValues [
	reuseValues := true.
]

{ #category : #'as yet unclassified' }
PhaROSSensorMultiplexor >> sensors: anArrayOfTopicBuilder [
	sensors := anArrayOfTopicBuilder collect: [ : builder | 
		| valueHolder |
		valueHolder := PhaROSValueHolder new.
		builder for: [ : data : tstamp |  
			valueHolder set: data with: tstamp. 
		]; connect.	
		valueHolder.
	]
]

{ #category : #'as yet unclassified' }
PhaROSSensorMultiplexor >> tick [
	| sync |
	sync := sensors collect: [ : s | (s isValidFor: tolerance ) not ].
	(sync size = sensors size ) ifTrue: [
		self callback cull: (sync collect: #value).
		self mainteinance.
	].
]

{ #category : #'as yet unclassified' }
PhaROSSensorMultiplexor >> tolerance: aToleranceInMilliseconds [
	tolerance := aToleranceInMilliseconds 
]
