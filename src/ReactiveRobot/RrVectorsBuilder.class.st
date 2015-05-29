Class {
	#name : #RrVectorsBuilder,
	#superclass : #ChaDefaultInOutComponent,
	#instVars : [
		'sensorAngles'
	],
	#category : #'ReactiveRobot-Kernel'
}

{ #category : #acting }
RrVectorsBuilder >> addVectorTo: vectors length: length angle: angle [
	| distanceVector |
	distanceVector := VeVector 
		length: length
		angle: angle.
	vectors add: distanceVector
]

{ #category : #acting }
RrVectorsBuilder >> newOutputFrom: distances [
	| vectors |
	vectors := OrderedCollection new: distances size.
	distances with: self sensorAngles do: [ : distance : angle|
		self addVectorTo: vectors length: distance angle: angle
	].
	^vectors
]

{ #category : #accessing }
RrVectorsBuilder >> sensorAngles [
	^sensorAngles
]

{ #category : #'initialize-release' }
RrVectorsBuilder >> sensorAngles: radians [
	sensorAngles := radians
]
