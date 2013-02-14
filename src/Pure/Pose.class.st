Class {
	#name : #Pose,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'orientation'
	],
	#category : #'Pure-BaseTypes'
}

{ #category : #'as yet unclassified' }
Pose class >> x: anX y: anY o: anO [
	^ Pose new x: anX ;y: anY ; orientation: anO; yourself.
]

{ #category : #accessing }
Pose >> asString [
	^ '[x:', self x asString,'] y:[', self y asString,  '] o:[', self orientation  asString, ']'.
]

{ #category : #accessing }
Pose >> closeTo: anOtherPose [

	^ 		(self x closeTo: anOtherPose x ) 
		and: [ (self y closeTo: anOtherPose y ) 
		and: [ (self orientation  closeTo: anOtherPose orientation) ] ].

]

{ #category : #accessing }
Pose >> initialize [ 
	x := 0.0.
	y := 0.0. 
	orientation := 0.0. 
]

{ #category : #accessing }
Pose >> orientation [ 
	^ orientation 
]

{ #category : #accessing }
Pose >> orientation: anOrientation [
	orientation  := anOrientation.
]

{ #category : #accessing }
Pose >> x [
	^ x
]

{ #category : #accessing }
Pose >> x: anX [
	x := anX.
]

{ #category : #accessing }
Pose >> y [
	^ y
]

{ #category : #accessing }
Pose >> y: aFloat [ 
	y := aFloat
]
