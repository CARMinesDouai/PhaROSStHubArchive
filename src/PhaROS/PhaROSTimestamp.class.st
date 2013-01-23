Class {
	#name : #PhaROSTimestamp,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'offset'
	],
	#category : #'PhaROS-Kernel-Types'
}

{ #category : #'as yet unclassified' }
PhaROSTimestamp class >> defaultOffset [
	^ 0
	" -3600 "
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp class >> fromUnixTime: anAmountOfSeconds  nanoSeconds: anAmountOfNSeconds [ 
	^ super new timestamp: (DateAndTime unixEpoch  + (Time seconds: anAmountOfSeconds nanoSeconds: anAmountOfNSeconds  ))
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp class >> new [
	^ super new timestamp: DateAndTime unixEpoch ; offset: self defaultOffset ; yourself .
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp class >> now [
	^ super new timestamp: DateAndTime now ; offset: self defaultOffset ; yourself .
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
PhaROSTimestamp >> offset: anOffset [
	offset := anOffset.
]

{ #category : #'as yet unclassified' }
PhaROSTimestamp >> seconds [
	^ timestamp asUnixTime + offset.
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
