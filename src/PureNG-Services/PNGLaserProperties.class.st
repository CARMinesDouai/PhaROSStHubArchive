Class {
	#name : #PNGLaserProperties,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'orientation',
		'echoesCount'
	],
	#category : #'PureNG-ServiceData'
}

{ #category : #accessing }
PNGLaserProperties >> echoesCount [
	^ echoesCount
]

{ #category : #accessing }
PNGLaserProperties >> echoesCount: anObject [
	echoesCount := anObject
]

{ #category : #accessing }
PNGLaserProperties >> orientation [
	^ orientation
]

{ #category : #accessing }
PNGLaserProperties >> orientation: anObject [
	orientation := anObject
]

{ #category : #accessing }
PNGLaserProperties >> x [
	^ x
]

{ #category : #accessing }
PNGLaserProperties >> x: anObject [
	x := anObject
]

{ #category : #accessing }
PNGLaserProperties >> y [
	^ y
]

{ #category : #accessing }
PNGLaserProperties >> y: anObject [
	y := anObject
]
