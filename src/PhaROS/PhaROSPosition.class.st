"
A PhaROSPosition is a 3 dimension position representation
"
Class {
	#name : #PhaROSPosition,
	#superclass : #PhaROS3DVector,
	#instVars : [
		'x',
		'y',
		'z'
	],
	#category : #'PhaROS-Util-Geometry'
}

{ #category : #'as yet unclassified' }
PhaROSPosition class >> fromTranslation: aTranslation [
	^self x: aTranslation x y: aTranslation y  z: aTranslation z.
]

{ #category : #converting }
PhaROSPosition >> asPose [ 
	^PhaROSPose position: self orientation: PhaROSQuaternion zero.
]
