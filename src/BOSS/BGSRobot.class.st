"
BGSRobot is a basic robot that has an identifier (id) and body deployed in some terrain.
It does nothing. To make it perform some action, subclasses are likely to override method step 

Instance Variables:
	id	<Symbol> Identifier of the robot. It is recommanded to assign each robot a unique ID
	body	<BGSRobotBody>
"
Class {
	#name : #BGSRobot,
	#superclass : #Object,
	#instVars : [
		'id',
		'body'
	],
	#category : #'BOSS-Kernel'
}

{ #category : #'instance creation' }
BGSRobot class >> number: aNumber [
	^self new
		number: aNumber;
		yourself
]

{ #category : #'instance creation' }
BGSRobot class >> withId: aSymbol [
	^self new
		id: aSymbol;
		yourself
]

{ #category : #accessing }
BGSRobot >> body [
	^ body
]

{ #category : #'initialize-release' }
BGSRobot >> body: aRobotBody [
	body := aRobotBody.
	body bot: self
]

{ #category : #'initialize-release' }
BGSRobot >> bodyClass [
	^BGSRobotBody.

]

{ #category : #moving }
BGSRobot >> goForward [
	self body goForward
]

{ #category : #moving }
BGSRobot >> goForwardBy: steps [
	steps timesRepeat: [self goForward]
]

{ #category : #sensing }
BGSRobot >> heading [
	^self body heading
]

{ #category : #sensing }
BGSRobot >> heading: aNumber [
	^self body heading: aNumber
]

{ #category : #accessing }
BGSRobot >> id [
	^ id
]

{ #category : #'initialize-release' }
BGSRobot >> id: anObject [
	id := anObject asSymbol
]

{ #category : #'initialize-release' }
BGSRobot >> initialize [ 
	super initialize.
	self body: self bodyClass new.

]

{ #category : #moving }
BGSRobot >> jumpTo: aPoint [
	self body position: aPoint
]

{ #category : #'initialize-release' }
BGSRobot >> jumpTo: aPoint in: terrain [
	self body jumpTo: aPoint in: terrain
]

{ #category : #accessing }
BGSRobot >> number: aNumber [
	self id: 'robot', aNumber printString
]

{ #category : #sensing }
BGSRobot >> position [
	^self body position
]

{ #category : #stepping }
BGSRobot >> step [
	^self
]

{ #category : #moving }
BGSRobot >> turnBy: number [ 
	number < 0 ifTrue: [^self turnLeftBy: number negated].
	self turnRightBy: number
]

{ #category : #moving }
BGSRobot >> turnLeft [
	self body turnLeft
]

{ #category : #moving }
BGSRobot >> turnLeftBy: steps [
	steps timesRepeat: [self turnLeft]
]

{ #category : #moving }
BGSRobot >> turnRight [
	self body turnRight
]

{ #category : #moving }
BGSRobot >> turnRightBy: steps [ 
	steps timesRepeat: [self turnRight]
]

{ #category : #moving }
BGSRobot >> turnTowards: aPoint [
	self body turnTowards: aPoint
]
