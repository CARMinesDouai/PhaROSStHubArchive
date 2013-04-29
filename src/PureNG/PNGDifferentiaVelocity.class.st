Class {
	#name : #PNGDifferentiaVelocity,
	#superclass : #Object,
	#instVars : [
		'linear',
		'angular'
	],
	#category : #'PureNG-ServiceData'
}

{ #category : #accessing }
PNGDifferentiaVelocity >> angular [
	^ angular
]

{ #category : #accessing }
PNGDifferentiaVelocity >> angular: anObject [
	angular := anObject
]

{ #category : #accessing }
PNGDifferentiaVelocity >> linear [
	^ linear
]

{ #category : #accessing }
PNGDifferentiaVelocity >> linear: anObject [
	linear := anObject
]
