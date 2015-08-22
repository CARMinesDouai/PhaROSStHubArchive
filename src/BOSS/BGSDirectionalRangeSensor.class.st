"
I am a sensor that measures the number of empty cells between the robot and an obstacle in a particular direction. An obstacle being any non-empty cell.


"
Class {
	#name : #BGSDirectionalRangeSensor,
	#superclass : #BGSBodyPart,
	#instVars : [
		'range'
	],
	#category : #'BOSS-BodyParts'
}

{ #category : #'instance creation' }
BGSDirectionalRangeSensor class >> botBody: robotBody name: sensorName range: maxDistanceToObstacle [
	^(self botBody: robotBody name: sensorName)
		range: maxDistanceToObstacle;
		yourself
]

{ #category : #visiting }
BGSDirectionalRangeSensor >> acceptVisitor: aVisitor [
	aVisitor visitDirectionalRangeSensor: self 
	
]

{ #category : #'initialize-release' }
BGSDirectionalRangeSensor >> defaultRange [
	^1
]

{ #category : #sensing }
BGSDirectionalRangeSensor >> distanceToObstacle [
	1 to: self range do: [:distance|
		(self isObstacleAtDistance: distance) ifTrue: [^distance - 1].
	].
	^self range
]

{ #category : #accessing }
BGSDirectionalRangeSensor >> heading [
	^self botBody heading
]

{ #category : #'initialize-release' }
BGSDirectionalRangeSensor >> initialize [ 
	super initialize.
	self range: self defaultRange
]

{ #category : #sensing }
BGSDirectionalRangeSensor >> isObstacleAtDistance: distance [
	|cellPosition|
	cellPosition := self position + (distance * self heading).
	^(self terrain isEmptyCellAt: cellPosition) not
]

{ #category : #accessing }
BGSDirectionalRangeSensor >> range [
	^ range
]

{ #category : #accessing }
BGSDirectionalRangeSensor >> range: anObject [
	range := anObject
]
