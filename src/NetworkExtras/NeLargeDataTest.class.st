Class {
	#name : #NeLargeDataTest,
	#superclass : #TestCase,
	#traits : 'NeTWait',
	#classTraits : 'NeTWait classTrait',
	#category : #'NetworkExtras-UDP-SendReceiveLargeData'
}

{ #category : #'data source' }
NeLargeDataTest >> dataSource [
	^ SmalltalkImage current sourcesFile asFileReference 
]

{ #category : #testing }
NeLargeDataTest >> get100KBytesOfSourceFile [
	^ self dataSource readStream next: 100000
]

{ #category : #testing }
NeLargeDataTest >> get10KBytesOfSourceFile [
	^ self dataSource readStream next: 10000
]

{ #category : #testing }
NeLargeDataTest >> get50KBytesOfSourceFile [
	^ self dataSource readStream next: 50000
]

{ #category : #testing }
NeLargeDataTest >> get5KBytesOfSourceFile [
	^ self get50KBytesOfSourceFile last: 5000
]
