Class {
	#name : #NeLargeDataTest,
	#superclass : #TestCase,
	#traits : 'NeTWait',
	#classTraits : 'NeTWait classTrait',
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
