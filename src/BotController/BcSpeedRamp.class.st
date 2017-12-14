Class {
	#name : #BcSpeedRamp,
	#superclass : #BcBodyDecorator,
	#instVars : [
		'leftSpeed',
		'rightSpeed',
		'newValueWeight',
		'oldAverageWeight'
	],
	#category : #'BotController-OLD-Body'
}

{ #category : #'instance creation' }
BcSpeedRamp class >> valuesCount: anInteger [
	^self new 
		valuesCount: anInteger;
		yourself 
]

{ #category : #actions }
BcSpeedRamp >> addValue: newValue toAverage: average [
	^ average * oldAverageWeight + (newValue * newValueWeight)
]

{ #category : #initialization }
BcSpeedRamp >> initialize [
	super initialize.
	self reset
]

{ #category : #actions }
BcSpeedRamp >> leftSpeed: newLeftSpeed rightSpeed: newRightSpeed [
	leftSpeed := self addValue: newLeftSpeed toAverage: leftSpeed.
	rightSpeed := self addValue: newRightSpeed toAverage: rightSpeed.
	super leftSpeed: leftSpeed rightSpeed: rightSpeed 
]

{ #category : #initialization }
BcSpeedRamp >> reset [
	leftSpeed := 0.
	rightSpeed := 0
]

{ #category : #accessing }
BcSpeedRamp >> valuesCount: count [
	newValueWeight := 1/count.
	oldAverageWeight := (count - 1)/count.
]
