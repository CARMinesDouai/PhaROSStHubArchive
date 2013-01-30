Class {
	#name : #PhaROSTimestamp,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'offset'
	],
	#classInstVars : [
		'DefaultOffset'
	],
	#category : #'PhaROS-Types-Basic'
}

{ #category : #'as yet unclassified' }
PhaROSTimestamp class >> defaultOffset [
	^ DefaultOffset
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp class >> defaultOffset: anOffset [
	DefaultOffset := anOffset.
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp class >> fromUnixTime: anAmountOfSeconds  nanoSeconds: anAmountOfNSeconds [ 
	^ super new timestamp: ((DateAndTime fromUnixTime: anAmountOfSeconds)  + (Time seconds: 0 nanoSeconds: anAmountOfNSeconds ))
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp class >> initialize [ 
	DefaultOffset := 0.
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp class >> new [
	^ super new timestamp:( DateAndTime fromUnixTime: 0) ; offset: self defaultOffset ; yourself .
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp class >> now [
	^ super new timestamp: DateAndTime now ; offset: self defaultOffset ; yourself .
]

{ #category : #operations }
PhaROSTimestamp >> + aDuration [
	^ PhaROSTimestamp new timestamp: timestamp + aDuration ; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp >> closeTo: anOtherPhaROSTimeStamp [
	^ timestamp = anOtherPhaROSTimeStamp timestamp.
	
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp >> nanoSeconds [
	^ timestamp nanoSecond.
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp >> nanoSeconds: anAmountOfNSeconds [ 
	timestamp nanoSeconds: anAmountOfNSeconds 
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp >> offset [ 
	^ offset.
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp >> offset: anOffset [
	offset := anOffset.
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp >> seconds [
	^ timestamp asUnixTime + self offset.
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp >> seconds: anAmountOfSeconds [
	timestamp seconds: anAmountOfSeconds.
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp >> seconds: anAmountOfSeconds  nanoSeconds: anAmountOfNSeconds [ 
	timestamp := (DateAndTime fromUnixTime: anAmountOfSeconds) + (Time seconds: 0 nanoSeconds: anAmountOfNSeconds ).
	^ timestamp.
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp >> timestamp [ 
	^ timestamp.
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp >> timestamp: aDateAndTime [
	timestamp := aDateAndTime.
	
]
