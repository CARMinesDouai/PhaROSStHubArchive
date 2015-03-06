Class {
	#name : #'Geometry_msgsTwistForTest',
	#superclass : #Object,
	#instVars : [
		'linear',
		'angular'
	],
	#category : #IronMinesTest
}

{ #category : #'as yet unclassified' }
Geometry_msgsTwistForTest >> angular [
	^ angular
]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistForTest >> angular: aVector3 [ 
	angular := aVector3
]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistForTest >> linear [
	^ linear
]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistForTest >> linear: aPoint [ 
	linear := aPoint
]
