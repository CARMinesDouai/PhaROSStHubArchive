Class {
	#name : #LaserEcho,
	#superclass : #Object,
	#instVars : [
		'angle',
		'distance'
	],
	#category : #'Pure-Services'
}

{ #category : #'initialize-release' }
LaserEcho class >> createEchoWithAngle: angle andFloatDistance: aFloat [
	| echo |
	echo:= LaserEcho new.
	echo angle: angle.
	echo distance: aFloat.
	^echo 
]

{ #category : #accessing }
LaserEcho >> angle [
	^ angle
]

{ #category : #accessing }
LaserEcho >> angle: anObject [
	angle := anObject
]

{ #category : #accessing }
LaserEcho >> asString [ 
	^ '----- angle: ', angle asString, ' distance: ', distance asString.
]

{ #category : #accessing }
LaserEcho >> distance [
	^ distance
]

{ #category : #accessing }
LaserEcho >> distance: anObject [
	distance := anObject
]
