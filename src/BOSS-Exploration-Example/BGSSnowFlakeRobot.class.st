"
see comment of BGSChristmasSimulation
"
Class {
	#name : #BGSSnowFlakeRobot,
	#superclass : #BGSRobot,
	#instVars : [
		'simulation'
	],
	#category : #'BOSS-Christmas2011'
}

{ #category : #'initialize-release' }
BGSSnowFlakeRobot >> bodyClass [ 
	^BGSRangeSensorBeltRobotBody
]

{ #category : #stepping }
BGSSnowFlakeRobot >> initialize [
	super initialize.
	body heading: 0@1.
]

{ #category : #'initialize-release' }
BGSSnowFlakeRobot >> jumpTo: aPoint in: terrain [
	super jumpTo: aPoint in: terrain.
	self addDependent: terrain.
	self changed
]

{ #category : #exploring }
BGSSnowFlakeRobot >> rangeSensorBelt [
	^self body part: #rangeSensorBelt
]

{ #category : #exploring }
BGSSnowFlakeRobot >> sensedPositions [
	^self rangeSensorBelt sensedPositions
]

{ #category : #accessing }
BGSSnowFlakeRobot >> simulation [
	^ simulation
]

{ #category : #accessing }
BGSSnowFlakeRobot >> simulation: anObject [
	simulation := anObject
]

{ #category : #stepping }
BGSSnowFlakeRobot >> step [
	|rotation bodyCell|
	bodyCell := self body cell.
	bodyCell color = Color gray ifTrue: [
		bodyCell color: Color white].
	rotation := (-1 to: 1) atRandom.
	self turnBy: rotation.
	self goForward.
	self turnBy: rotation negated.
	self changed
]

{ #category : #accessing }
BGSSnowFlakeRobot >> terrain [
	^self simulation terrain
]
