"
A PhaROSPosition is a 3 dimension position representation
"
Class {
	#name : #PhaROSPosition,
	#superclass : #PhaROS3DVector,
	#category : #'PhaROS-Util-Geometry'
}

{ #category : #'as yet unclassified' }
PhaROSPosition class >> fromTranslation: aTranslation [
	^self x: aTranslation x y: aTranslation y  z: aTranslation z.
]

{ #category : #converting }
PhaROSPosition >> asPoint [
	^ x @ y 
]

{ #category : #converting }
PhaROSPosition >> asPose [ 
	^PhaROSPose position: self orientation: PhaROSQuaternion zero.
]
