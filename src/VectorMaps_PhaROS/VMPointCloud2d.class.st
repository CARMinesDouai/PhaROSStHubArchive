"
This is an intermediate data storage class, lieing between a laser scan message and a local map. we use this class for storage when performing ICP.
"
Class {
	#name : #VMPointCloud2d,
	#superclass : #Object,
	#instVars : [
		'points',
		'sensorCenter'
	],
	#category : #'VectorMaps_PhaROS-Helper'
}

{ #category : #'as yet unclassified' }
VMPointCloud2d class >> fromVMLocalMap: aMap [
	^(self new)
		fromVMLocalMap: aMap;
		yourself.
]

{ #category : #'as yet unclassified' }
VMPointCloud2d >> applyTransform: aVMTFMatrix [
	| tf |
	
	tf := aVMTFMatrix asVMTFMatrix.
	
	points := points collect: [ :aPoint |
		aPoint applyTransform: tf
	].
	
	

]

{ #category : #converting }
VMPointCloud2d >> fromMsg: aMsg [
	"note: this method ignores the transformation and creates the pointcloud in the local frame of the sensor"
	| angle angleInc ranges dataCount |
	
	angle := aMsg angle_min.
	angleInc := aMsg angle_increment.
	ranges := aMsg ranges.
	dataCount := aMsg ranges size.
	
	angleInc := aMsg angle_min - aMsg angle_max / (dataCount - 1).
	self logCr: self class name, ':: ', 'inc (msg)=', aMsg angle_increment printString, ', inc (calc)=', angleInc printString.
	
	1 to: dataCount do: [ :i |
		| dist point |
		dist := ranges at: i.
		
		"note: isFinite also checks if the number is NaN, isInfinite does not"
		dist isFinite ifTrue: [
			point := Point x: (((angle) cos negated) * dist) y: (((angle) sin) * dist).
			points add: point.
		].
		
		angle := angle + angleInc.
	].

]

{ #category : #converting }
VMPointCloud2d >> fromVMLocalMap: aMap [
	aMap lineSegments allButLastDo: [ :lineSeg |
		points add: lineSeg pointA.
	].
	
	sensorCenter := aMap lineSegments last pointA.
]

{ #category : #initialization }
VMPointCloud2d >> initialize [
	points := OrderedCollection new.
	sensorCenter := 0@0.
]

{ #category : #accessing }
VMPointCloud2d >> points [
	^points.
]

{ #category : #accessing }
VMPointCloud2d >> points: aCollection [
	points := aCollection.
]

{ #category : #printing }
VMPointCloud2d >> printString [
	| string |
	
	string := super printString,
		' (points size=',
		(points
			ifNil: [ 'nil' ]
			ifNotNil: [ points size printString ]),
		')'.
	
	^string.

]

{ #category : #accessing }
VMPointCloud2d >> sensorCenter [
	^sensorCenter.
]

{ #category : #accessing }
VMPointCloud2d >> sensorCenter: aPoint [
	sensorCenter := aPoint.
]
