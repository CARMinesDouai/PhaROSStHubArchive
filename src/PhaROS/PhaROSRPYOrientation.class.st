Class {
	#name : #PhaROSRPYOrientation,
	#superclass : #Object,
	#instVars : [
		'roll',
		'pitch',
		'yaw'
	],
	#category : #'PhaROS-Util-Geometry'
}

{ #category : #'as yet unclassified' }
PhaROSRPYOrientation class >> roll: roll pitch: pitch yaw: yaw [
	^ self new roll: roll; pitch: pitch; yaw: yaw; yourself.
]

{ #category : #operators }
PhaROSRPYOrientation >> + anOther [
	^PhaROSRPYOrientation roll: roll + anOther roll pitch: pitch + anOther pitch yaw: yaw + anOther yaw.
]

{ #category : #operators }
PhaROSRPYOrientation >> - anOther [
	^ PhaROSRPYOrientation roll: roll - anOther roll pitch: pitch - anOther pitch yaw: yaw - anOther yaw.
]

{ #category : #convertions }
PhaROSRPYOrientation >> as2DOrientation [ 
	^ PhaROS2DOrientation z: yaw.
]

{ #category : #convertions }
PhaROSRPYOrientation >> asQuaternion [ 
	| arr |
	arr:= PhaROSGeometryTransformations new quaternationFromEulerFor: roll and: pitch and: yaw.
	^ PhaROSQuaternion x: (arr at:1) y: (arr at:2) z:(arr at:3)  w:(arr at:4). 
]

{ #category : #convertions }
PhaROSRPYOrientation >> asRPY [ 
	^ self
]

{ #category : #accessing }
PhaROSRPYOrientation >> pitch [
	^ pitch
]

{ #category : #accessing }
PhaROSRPYOrientation >> pitch: anObject [
	pitch := anObject
]

{ #category : #printing }
PhaROSRPYOrientation >> printOn: aStream [ 
	('RPY({1},{2},{3})' format: { roll . pitch . yaw }) printOn: aStream.
]

{ #category : #accessing }
PhaROSRPYOrientation >> roll [
	^ roll
]

{ #category : #accessing }
PhaROSRPYOrientation >> roll: anObject [
	roll := anObject
]

{ #category : #accessing }
PhaROSRPYOrientation >> yaw [
	^ yaw
]

{ #category : #accessing }
PhaROSRPYOrientation >> yaw: anObject [
	yaw := anObject
]
