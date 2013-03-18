Class {
	#name : #PhaROSMap,
	#superclass : #Object,
	#instVars : [
		'grid',
		'origin',
		'resolution',
		'ros'
	],
	#category : #'PhaROS-MapMatcher'
}

{ #category : #'as yet unclassified' }
PhaROSMap class >> for: aRosNode [
	^ self new ros: aRosNode;yourself.
]

{ #category : #'as yet unclassified' }
PhaROSMap >> at: aPoint [
	^ grid at: aPoint x at: aPoint y.
]

{ #category : #'as yet unclassified' }
PhaROSMap >> heigth [
	^ grid columnCount.
]

{ #category : #'as yet unclassified' }
PhaROSMap >> ros: aRosNode [
	ros := aRosNode.
	
	ros interestedIn: '/map' typedAs: 'nav_msg/OccupancyGrid' toDo: [ : aMessage | 
		| dataStream |
		origin := aMessage info origin.
		resolution := aMessage info resolution.
		dataStream := ReadStream on: aMessage data.
		
		grid := Matrix rows: aMessage info heigth columns: aMessage info width tabulate: [ : r : c | 
			dataStream next.
		].
	].



]

{ #category : #'as yet unclassified' }
PhaROSMap >> width [ 
	^ grid rowCount 
 
]

{ #category : #'as yet unclassified' }
PhaROSMap >> zeroAngle [ 
	^( PhaROSGeometryTransformations new eulerFromQuaternation: origin orientation) at:3. " Z axis "
]
