Class {
	#name : #FruitComparisons,
	#superclass : #Object,
	#category : #'Equals-Example'
}

{ #category : #comparisons }
FruitComparisons class >> compareApplesOfDifferentColors [
	"self compareApplesOfDifferentColors"

	| apple1 apple2 |
	apple1 := Apple color: Color red.
	apple2 := Apple color: Color yellow.
	self display: apple1 = apple2
]

{ #category : #comparisons }
FruitComparisons class >> compareApplesOfSameColor [
	"self compareApplesOfSameColor"

	| apple1 apple2 |
	apple1 := Apple color: Color red.
	apple2 := Apple color: Color red.
	self display: apple1 = apple2
]

{ #category : #comparisons }
FruitComparisons class >> compareApplesOfSameColorAtDifferentStages [
	"self compareApplesOfSameColorAtDifferentStages"

	| apple1 apple2 |
	apple1 := Apple color: Color red.
	apple1 beRipe.
	apple2 := Apple color: Color yellow.
	apple2 beRotten.	
	self display: apple1 = apple2
]

{ #category : #comparisons }
FruitComparisons class >> compareYellowAppleAndBanana [
	"self compareYellowAppleAndBanana"

	| apple banana |
	apple := Apple color: Color yellow.
	banana := Banana new.
	self display: apple = banana
]

{ #category : #displaying }
FruitComparisons class >> display: aBoolean [
	| displayColor displayLabel |
	displayLabel := aBoolean ifTrue: [ 'Equal' ] ifFalse: [ 'Different' ].
	displayColor := aBoolean ifTrue: [ Color green ] ifFalse: [ Color yellow ].
	GrowlMorph 
		openWithLabel: displayLabel
		contents: ''
		backgroundColor: displayColor
		labelColor: Color black
]
