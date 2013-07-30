Class {
	#name : #PNGDifferentialVelocity,
	#superclass : #Object,
	#instVars : [
		'linear',
		'angular'
	],
	#category : #'PureNG-ServiceData'
}

{ #category : #accessing }
PNGDifferentialVelocity >> angular [
	^ angular
]

{ #category : #accessing }
PNGDifferentialVelocity >> angular: anObject [
	angular := anObject
]

{ #category : #accessing }
PNGDifferentialVelocity >> linear [
	^ linear
]

{ #category : #accessing }
PNGDifferentialVelocity >> linear: anObject [
	linear := anObject
]
