"
Quelques fonctions mathématiques utiles
"
Class {
	#name : #MathFactory,
	#superclass : #Object,
	#category : #'IronMines-Nodelets'
}

{ #category : #'as yet unclassified' }
MathFactory class >> calculateAngleBetween: currentPos and: finalPos [
|X x Y y|
	x := currentPos x.
	y := currentPos y.
	X := finalPos x.
	Y := finalPos y.

	(y=Y) ifTrue:[
		(x>X) ifTrue:[
			^MathFactory pi.
		] ifFalse:[
			^0.
		]
	] ifFalse:[
		^(Y-y)/((Y-y) abs) * (((X-x)/(((X-x)*(X-x))+((Y-y)*(Y-y))) sqrt) arcCos). 
	]
]

{ #category : #'as yet unclassified' }
MathFactory class >> degresToRadians:degres [
^(degres *MathFactory pi )/ 180.

]

{ #category : #'as yet unclassified' }
MathFactory class >> modulo2Pi: unReel [
	[unReel<(0-(MathFactory pi))] whileTrue:[ unReel := unReel+(2*(MathFactory pi)).].	
	[unReel > (MathFactory pi)] whileTrue:[ unReel := unReel-(2*(MathFactory pi)).].
	^unReel.	
]

{ #category : #'as yet unclassified' }
MathFactory class >> pi [
^3.141592653589793.
	
]
