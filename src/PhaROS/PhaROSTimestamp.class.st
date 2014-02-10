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

{ #category : #converting }
PhaROSTimestamp >> asDateAndTime [
	^ timestamp
]

{ #category : #comparing }
PhaROSTimestamp >> closeTo: anOtherPhaROSTimeStamp [
	^ timestamp = anOtherPhaROSTimeStamp timestamp.
	
]

{ #category : #converting }
PhaROSTimestamp >> nanoSeconds [
	^ timestamp nanoSecond.
]

{ #category : #'simple instance creation' }
PhaROSTimestamp >> nanoSeconds: anAmountOfNSeconds [ 
	timestamp nanoSeconds: anAmountOfNSeconds 
]

{ #category : #accessing }
PhaROSTimestamp >> seconds [
	^ timestamp asUnixTime .
]

{ #category : #private }
PhaROSTimestamp >> seconds: anAmountOfSeconds [
	timestamp seconds: anAmountOfSeconds.
]

{ #category : #private }
PhaROSTimestamp >> seconds: anAmountOfSeconds  nanoSeconds: anAmountOfNSeconds [ 
	timestamp := (DateAndTime fromUnixTime: anAmountOfSeconds) + (Time seconds: 0 nanoSeconds: anAmountOfNSeconds ).
	^ timestamp.
]

{ #category : #converting }
PhaROSTimestamp >> secondsUTC [
	^ timestamp asUnixTime - (timestamp offset asSeconds).
]

{ #category : #accessing }
PhaROSTimestamp >> timestamp [ 
	^ timestamp.
]

{ #category : #accessing }
PhaROSTimestamp >> timestamp: aDateAndTime [
	timestamp := aDateAndTime.
	
]
