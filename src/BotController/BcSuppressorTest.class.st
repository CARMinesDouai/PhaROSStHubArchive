Class {
	#name : #BcSuppressorTest,
	#superclass : #TestCase,
	#instVars : [
		'suppressor'
	],
	#category : #'BotController-Tests'
}

{ #category : #testing }
BcSuppressorTest >> setUp [
	super setUp.
	suppressor := BcSuppressor new
]

{ #category : #testing }
BcSuppressorTest >> testDoubleSuppressBeforeTheEndOfDuration [
	| aDuration |
	aDuration := 50 milliSeconds.
	suppressor duration: aDuration.
	suppressor start.
	(aDuration / 2) wait.
	suppressor start.
	(aDuration / 2) wait.
	self deny: suppressor isTimeOver.
	(aDuration / 2) wait.
	self assert: suppressor isTimeOver.

]

{ #category : #testing }
BcSuppressorTest >> testSuppressingForSomeDuration [
	{50 milliSeconds.
	100 milliSeconds}
		do: [ :aDuration | 
			suppressor duration: aDuration.
			suppressor start.
			self deny: suppressor isTimeOver.
			(aDuration / 2) wait.
			self deny: suppressor isTimeOver.
			(aDuration / 2) wait.
			self assert: suppressor isTimeOver ]
]
