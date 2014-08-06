"
I am a robot body deployed in a terrain.
I have a collection of parts, each having an identifier. I retreive parts given their identifiers using message:
-part: aSymbol

Instance Variables:
	terrain	<BGSGrid> terrain where I am deployed
	position	<Point> coordinates of the cell occupied in terrain
	partsDict <Dictionary : Symbol -> BGSBodyPart> gathers component parts such as range sensors and wireless communication interface
"
Class {
	#name : #BGSRobotBody,
	#superclass : #BGSCellContent,
	#instVars : [
		'bot',
		'cell',
		'heading',
		'partsDict'
	],
	#classVars : [
		'Headings'
	],
	#category : #'BOSS-Kernel'
}

{ #category : #'class initialization' }
BGSRobotBody class >> initialize [ 
	Headings := {(0 @ -1). (1 @ -1). (1 @ 0). (1 @ 1). (0 @ 1).  (-1 @ 1). (-1 @ 0). (-1 @ -1)}.
]

{ #category : #visiting }
BGSRobotBody >> acceptVisitor: aVisitor [
	aVisitor visitRobotBody: self.

]

{ #category : #'initialize-release' }
BGSRobotBody >> addPart: newPart named:  newName [
	self partsDict at: newName put: newPart 
]

{ #category : #accessing }
BGSRobotBody >> bot [
	^ bot
]

{ #category : #accessing }
BGSRobotBody >> bot: anObject [
	bot := anObject
]

{ #category : #accessing }
BGSRobotBody >> cell [
	^ cell
]

{ #category : #accessing }
BGSRobotBody >> cell: anObject [
	cell := anObject
]

{ #category : #moving }
BGSRobotBody >> goForward [
	self position: self position + self heading
]

{ #category : #moving }
BGSRobotBody >> goForwardBy: steps [
	steps timesRepeat: [self goForward]
]

{ #category : #accessing }
BGSRobotBody >> heading [
	^ heading
]

{ #category : #moving }
BGSRobotBody >> heading: aPoint [
	heading := aPoint.
	self terrain ifNotNil: [self terrain changed] "Trigger observer updates"
]

{ #category : #'initialize-release' }
BGSRobotBody >> initParts [
	self partsDict: Dictionary new.

]

{ #category : #'initialize-release' }
BGSRobotBody >> initialize [ 
	super initialize.
	self heading: 0 @ -1.
	self initParts.
	
]

{ #category : #'initialize-release' }
BGSRobotBody >> jumpTo: aPoint in: aBGSTerrain [ 
	aBGSTerrain put: self inCellAt: aPoint 

]

{ #category : #accessing }
BGSRobotBody >> part: id [
	^self partsDict at: id ifAbsent: [nil]
]

{ #category : #accessing }
BGSRobotBody >> parts [
	^self partsDict values
]

{ #category : #accessing }
BGSRobotBody >> partsDict [
	^ partsDict
]

{ #category : #accessing }
BGSRobotBody >> partsDict: anObject [
	partsDict := anObject
]

{ #category : #accessing }
BGSRobotBody >> position [
	^self cell position
]

{ #category : #moving }
BGSRobotBody >> position: aPoint [
 	self terrain move: self from: self position to: aPoint.

]

{ #category : #accessing }
BGSRobotBody >> terrain [
	self cell ifNil: [^nil].
	^self cell grid
]

{ #category : #moving }
BGSRobotBody >> turnLeft [
	| currentHeadingIndex nextHeadingIndex |
	currentHeadingIndex := Headings indexOf: self heading.
	nextHeadingIndex := currentHeadingIndex = 1 
		ifTrue: [8]
		ifFalse: [currentHeadingIndex - 1].
	self heading: (Headings at: nextHeadingIndex)
]

{ #category : #moving }
BGSRobotBody >> turnRight [
	| currentHeadingIndex nextHeadingIndex |
	currentHeadingIndex := Headings indexOf: self heading.
	nextHeadingIndex := currentHeadingIndex = 8 
		ifTrue: [1]
		ifFalse: [currentHeadingIndex + 1].
	self heading: (Headings at: nextHeadingIndex)
]

{ #category : #moving }
BGSRobotBody >> turnTowards: aPoint [
	|directionVector|
	directionVector := aPoint - self position.
	self heading: directionVector x sign @ directionVector y sign

]
