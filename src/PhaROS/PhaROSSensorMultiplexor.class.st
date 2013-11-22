Class {
	#name : #PhaROSSensorMultiplexor,
	#superclass : #Object,
	#instVars : [
		'sensors',
		'tolerance',
		'callback',
		'reuseValues',
		'ticked'
	],
	#category : #'PhaROS-Util-Sensor'
}

{ #category : #'as yet unclassified' }
PhaROSSensorMultiplexor class >> with: anArray [
	^ self new sensors: anArray; yourself .
]

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
PhaROSSensorMultiplexor >> initialize [ 
	ticked := 0.
]

{ #category : #'as yet unclassified' }
PhaROSSensorMultiplexor >> log: aString [
	ticked := ticked + 1.
	(ticked \\ 5 ) = 0 ifTrue:[ super log: aString. ]
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
	
	sync := sensors select: [ : s | s isValidFor: tolerance  ].
	(sync size = sensors size ) ifTrue: [
		self callback cull: (sync collect: #value).
		self mainteinance.
	] ifFalse: [
			self log: ' Waiting data from sensors  '.	
	].
]

{ #category : #'as yet unclassified' }
PhaROSSensorMultiplexor >> tolerance: aToleranceInMilliseconds [
	tolerance := aToleranceInMilliseconds 
]
