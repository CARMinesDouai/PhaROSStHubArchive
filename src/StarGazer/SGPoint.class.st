Class {
	#name : #SGPoint,
	#superclass : #Object,
	#traits : 'TEquality',
	#classTraits : 'TEquality classTrait',
	#instVars : [
		'x',
		'y',
		'z'
	],
	#category : #'StarGazer-Types'
}

{ #category : #'as yet unclassified' }
SGPoint class >> x: anX y: anY z: anZ [
	^ self new x: anX asNumber  ;y: anY asNumber ; z: anZ asNumber .
]

{ #category : #'as yet unclassified' }
SGPoint >> printOn: aStream [
	aStream nextPutAll: 'SG(', x asString, '|', y asString, '|', z asString ,')'.
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
