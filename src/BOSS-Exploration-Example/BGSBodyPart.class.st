"
BGSRangeSensor is an abstract superclass for range sensors.
Subclasses should implement:
-aceptVisitor: aVisitor


Instance Variables:
	range	<integer> the max distance to detect an obstacle. Cells beyond this distance are ignored.
	botBoy <BGSRobotBody> body of robot that owes the sensor

"
Class {
	#name : #BGSBodyPart,
	#superclass : #Object,
	#instVars : [
		'botBody',
		'name'
	],
	#category : #'BOSS-BodyParts'
}

{ #category : #'instance creation' }
BGSBodyPart class >> botBody: robotBody name: aSymbol [
	^self new
		botBody: robotBody name: aSymbol;
		yourself
]

{ #category : #visiting }
BGSBodyPart >> acceptVisitor: aVisitor [
	self subclassResponsibility
]

{ #category : #accessing }
BGSBodyPart >> botBody [
	^ botBody
]

{ #category : #'initialize-release' }
BGSBodyPart >> botBody: robotBody name: aSymbol [
	botBody := robotBody.
	name := aSymbol.
	botBody addPart: self named: aSymbol 
]

{ #category : #accessing }
BGSBodyPart >> cell [
	^self botBody cell
]

{ #category : #'initialize-release' }
BGSBodyPart >> isAcceptingVisitorsByDefault [
	^true
]

{ #category : #accessing }
BGSBodyPart >> name [
	^name
]

{ #category : #accessing }
BGSBodyPart >> position [ 
	^self botBody position
]

{ #category : #accessing }
BGSBodyPart >> terrain [
	^self botBody terrain
]
