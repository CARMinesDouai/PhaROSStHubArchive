Class {
	#name : #RrVectorsBuilder,
	#superclass : #ChaDefaultInOutComponent,
	#instVars : [
		'sensorAngles'
	],
	#category : #'ReactiveRobot-Kernel'
}

{ #category : #acting }
RrVectorsBuilder >> addVectorTo: vectors forObstacleAt: distanceToObstacle angle: angle [
	| distanceVector |
	distanceVector := VeVector 
		length: distanceToObstacle
		angle: angle.
	vectors add: distanceVector
]

{ #category : #acting }
RrVectorsBuilder >> newOutputFrom: distances [
	| vectors |
	vectors := OrderedCollection new: distances size.
	distances with: self sensorAngles do: [ :distanceToObstacle :angle|
		self addVectorTo: vectors forObstacleAt: distanceToObstacle angle: angle
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
