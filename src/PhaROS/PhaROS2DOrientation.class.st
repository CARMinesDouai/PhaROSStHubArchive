Class {
	#name : #PhaROS2DOrientation,
	#superclass : #Object,
	#instVars : [
		'z'
	],
	#category : #'PhaROS-Util-Geometry'
}

{ #category : #'as yet unclassified' }
PhaROS2DOrientation class >> z: aZAngle [
	^ self new z: aZAngle ; yourself 
]

{ #category : #operators }
PhaROS2DOrientation >> + anOther [
	^ PhaROS2DOrientation z: (z + anOther z)
]

{ #category : #operators }
PhaROS2DOrientation >> - anOther [
	^ PhaROS2DOrientation z: (z - anOther z)
]

{ #category : #convertions }
PhaROS2DOrientation >> as2DOrientation [
	^ self.
]

{ #category : #convertions }
PhaROS2DOrientation >> asQuaternion [ 
	^ self asRPY asQuaternion
]

{ #category : #convertions }
PhaROS2DOrientation >> asRPY [
	^ PhaROSRPYOrientation roll: 0.0 pitch: 0.0 yaw: z.
]

{ #category : #printing }
PhaROS2DOrientation >> printOn: aStream [ 
	('O({1})' format: { z}) printOn: aStream.
]

{ #category : #accessing }
PhaROS2DOrientation >> z [
	^ z
]

{ #category : #accessing }
PhaROS2DOrientation >> z: anObject [
	z := anObject
]
