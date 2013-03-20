Class {
	#name : #SGPoint,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'z'
	],
	#category : #'StarGazer-Types'
}

{ #category : #'as yet unclassified' }
SGPoint class >> x: anX y: anY z: anZ [
	^ self new x: anX ;y: anY; z: anZ.
]

{ #category : #accessing }
SGPoint >> x [
	^ x
]

{ #category : #'as yet unclassified' }
SGPoint >> x: anX [ 
	 x := anX.
]

{ #category : #accessing }
SGPoint >> y [

	^ y
]

{ #category : #'as yet unclassified' }
SGPoint >> y: anY [
	y := anY.
]

{ #category : #accessing }
SGPoint >> z [
	^ z
]

{ #category : #'as yet unclassified' }
SGPoint >> z: anZ [
	 z := anZ
]
