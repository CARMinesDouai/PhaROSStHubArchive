Class {
	#name : #RrVectorsBuilder,
	#superclass : #ChaDefaultInOutComponent,
	#instVars : [
		'vectorAngles'
	],
	#category : #'ReactiveRobot-Generic'
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
	distances with: self vectorAngles do: [ : distance : angle|
		self addVectorTo: vectors length: distance angle: angle
	].
	^vectors
]

{ #category : #accessing }
RrVectorsBuilder >> vectorAngles [
	^vectorAngles
]

{ #category : #'initialize-release' }
RrVectorsBuilder >> vectorAngles: radians [
	vectorAngles := radians
]
