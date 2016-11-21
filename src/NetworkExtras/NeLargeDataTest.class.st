Class {
	#name : #NeLargeDataTest,
	#superclass : #TestCase,
	#category : #'NetworkExtras-UDP-SendReceiveLargeData'
}

{ #category : #testing }
NeLargeDataTest >> get100KBytesOfSourceFile [
	^ SmalltalkImage current sourcesFile readStream next: 100000
]

{ #category : #testing }
NeLargeDataTest >> get10KBytesOfSourceFile [
	^SmalltalkImage current sourcesFile readStream next: 10000
]

{ #category : #testing }
NeLargeDataTest >> get50KBytesOfSourceFile [
	^ SmalltalkImage current sourcesFile readStream next: 50000
]

{ #category : #testing }
NeLargeDataTest >> get5KBytesOfSourceFile [
	^ self get50KBytesOfSourceFile last: 5000
]

{ #category : #testing }
NeLargeDataTest >> waitWhile: conditionBlock timeout: aDuration [
	| iterationCount iterationDuration |
	iterationDuration := 50 milliSeconds.
	iterationCount := (aDuration / iterationDuration) asFloat rounded + 1.
	iterationCount timesRepeat: [ 
		conditionBlock ifFalse: [^self].
		iterationDuration wait].
	self fail: 'Timeout'.
	
]
