Class {
	#name : #RrForceVectorsBuilder,
	#superclass : #ChaDefaultInOutComponent,
	#instVars : [
		'sensorAngles',
		'distanceThreshold'
	],
	#category : #'ReactiveRobot-CollisionAvoidance'
}

{ #category : #acting }
RrForceVectorsBuilder >> addForceVectorTo: vectors forObstacleAt: distanceToObstacle angle: angle [
	| forceVector |
	distanceToObstacle >= self distanceThreshold ifTrue: [ ^self].
	forceVector := RrVector 
		length: self distanceThreshold - distanceToObstacle
		angle: angle.
	vectors add: forceVector
]

{ #category : #accessing }
RrForceVectorsBuilder >> distanceThreshold [
	^ distanceThreshold
]

{ #category : #'initialize-release' }
RrForceVectorsBuilder >> distanceThreshold: anObject [
	distanceThreshold := anObject
]

{ #category : #acting }
RrForceVectorsBuilder >> newOutputFrom: distances [
	| vectors |
	vectors := Set new: distances size.
	distances with: self sensorAngles do: [ :distanceToObstacle :angle|
		self addForceVectorTo: vectors forObstacleAt: distanceToObstacle angle: angle
	].
	^vectors
]

{ #category : #accessing }
RrForceVectorsBuilder >> sensorAngles [
	^sensorAngles
]

{ #category : #'initialize-release' }
RrForceVectorsBuilder >> sensorAngles: radians [
	sensorAngles := radians
]
