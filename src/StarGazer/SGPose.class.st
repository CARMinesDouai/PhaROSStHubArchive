Class {
	#name : #SGPose,
	#superclass : #Object,
	#instVars : [
		'orientation',
		'position'
	],
	#category : #'StarGazer-Kernel'
}

{ #category : #construction }
SGPose class >> position: aPoint orientation: anOrientation [ 
	^self new position: aPoint; orientation: anOrientation ; yourself.
]

{ #category : #construction }
SGPose class >> x: anX y: anY z: anZ o: anScalarOrientation [
	^ self position: (SGPoint x: anX y: anY z: anZ) orientation: anScalarOrientation.
]

{ #category : #accessing }
SGPose >> orientation [
	^ orientation
]

{ #category : #'as yet unclassified' }
SGPose >> orientation: aScalarOrientation [
	orientation := aScalarOrientation 
]

{ #category : #acessing }
SGPose >> position [
	^ position
]

{ #category : #'as yet unclassified' }
SGPose >> position: aSGPoint [
	position := aSGPoint.
]
