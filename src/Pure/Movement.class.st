Class {
	#name : #Movement,
	#superclass : #Object,
	#instVars : [
		'linear',
		'angular'
	],
	#category : #'Pure-BaseTypes'
}

{ #category : #accessing }
Movement >> angular [
	^angular 
]

{ #category : #accessing }
Movement >> angular: anAngularVelocity [
	angular :=anAngularVelocity
]

{ #category : #accessing }
Movement >> initialize [ 
	angular := 0.0.
	linear := 0.0.
]

{ #category : #accessing }
Movement >> linear [ 
	^ linear.
]

{ #category : #accessing }
Movement >> linear: aLinearVelocity [ 
	linear := aLinearVelocity .
]
