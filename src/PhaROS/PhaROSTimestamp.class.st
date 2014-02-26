Class {
	#name : #PhaROSTimestamp,
	#superclass : #Object,
	#traits : 'TEquality',
	#classTraits : 'TEquality classTrait',
	#instVars : [
		'timestamp'
	],
	#category : #'PhaROS-Types-Basic'
}

{ #category : #'as yet unclassified' }
PhaROSTimestamp class >> fromUnixTime: anAmountOfSeconds  nanoSeconds: anAmountOfNSeconds [ 
	^ super new timestamp: ((DateAndTime fromUnixTime: anAmountOfSeconds)  + (Time seconds: 0 nanoSeconds: anAmountOfNSeconds ));
				  yourself.
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp class >> new [
	^ super new timestamp:( DateAndTime fromUnixTime: 0) ; yourself .
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp class >> now [
	^ super new timestamp: DateAndTime now ; yourself .
]

{ #category : #operations }
PhaROSTimestamp >> + aDuration [
	^ PhaROSTimestamp new timestamp: timestamp + aDuration ; yourself.
]

{ #category : #operations }
PhaROSTimestamp >> - aDateAndTime [
	^ timestamp - aDateAndTime asDateAndTime.
]

{ #category : #operations }
PhaROSTimestamp >> < aDateAndTime [
	^ timestamp < aDateAndTime asDateAndTime.
]

{ #category : #operations }
PhaROSTimestamp >> > aDateAndTime [
	^ timestamp > aDateAndTime asDateAndTime.
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp >> asDateAndTime [
	^ timestamp
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
PhaROSTimestamp >> seconds [
	^ timestamp asUnixTime .
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
PhaROSTimestamp >> secondsUTC [
	^ timestamp asUnixTime - (timestamp offset asSeconds).
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp >> timestamp [ 
	^ timestamp.
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp >> timestamp: aDateAndTime [
	timestamp := aDateAndTime.
	
]
