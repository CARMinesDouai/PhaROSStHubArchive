Class {
	#name : #IOService,
	#superclass : #RobulabService,
	#instVars : [
		'analogInputNumber',
		'analogOutputNumber',
		'digitalInputNumber',
		'digitalOutputNumber',
		'analogInputs',
		'analogOutputs',
		'digitalInputs',
		'digitalOutputs'
	],
	#category : #'Pure-Services'
}

{ #category : #accessing }
IOService >> analogInputNumber [
	^ analogInputNumber
]

{ #category : #accessing }
IOService >> analogInputNumber: anObject [
	analogInputNumber := anObject
]

{ #category : #accessing }
IOService >> analogInputs [
	^ analogInputs
]

{ #category : #accessing }
IOService >> analogInputs: anObject [
	analogInputs := anObject
]

{ #category : #accessing }
IOService >> analogOutputNumber [
	^ analogOutputNumber
]

{ #category : #accessing }
IOService >> analogOutputNumber: anObject [
	analogOutputNumber := anObject
]

{ #category : #accessing }
IOService >> analogOutputs [
	^ analogOutputs
]

{ #category : #accessing }
IOService >> analogOutputs: anObject [
	analogOutputs := anObject
]

{ #category : #accessing }
IOService >> digitalInputNumber [
	^ digitalInputNumber
]

{ #category : #accessing }
IOService >> digitalInputNumber: anObject [
	digitalInputNumber := anObject
]

{ #category : #accessing }
IOService >> digitalInputs [
	^ digitalInputs
]

{ #category : #accessing }
IOService >> digitalInputs: anObject [
	digitalInputs := anObject
]

{ #category : #accessing }
IOService >> digitalOutputNumber [
	^ digitalOutputNumber
]

{ #category : #accessing }
IOService >> digitalOutputNumber: anObject [
	digitalOutputNumber := anObject
]

{ #category : #accessing }
IOService >> digitalOutputs [
	^ digitalOutputs
]

{ #category : #accessing }
IOService >> digitalOutputs: anObject [
	digitalOutputs := anObject
]

{ #category : #request }
IOService >> getData [ 
| decoder |
	Transcript show:'- - - - - - - - - -';cr.
	Transcript show: ' Acquisition des données du IO Service:';cr.	
	( self analogInputs isNil )ifTrue: [
		self analogOutputs: Dictionary new.
		self analogInputs: Dictionary new.
		self digitalOutputs: Dictionary new.
		self digitalInputs: Dictionary new.
	].
	decoder :=  self get decoder.
	
	self analogInputNumber: decoder nextEncodedInt32.
	1 to: self analogInputNumber do: [
		:idx | 
		self analogInputs at: idx put: decoder nextEncodedInt32.
	].
	
	self analogOutputNumber: decoder nextEncodedInt32.
	1 to: self analogOutputNumber do: [
		:idx |
		self analogOutputs at: idx put: decoder nextEncodedInt16.
	].
		
	self digitalInputNumber: decoder nextEncodedInt32.

	self flag:#reallyWhatTheFuck.
	" this bytes are swallowed 'cause... FUCK YOU! thats why. '"
	decoder nextEncodedBytes: (self digitalInputNumber/8) asInteger.
	
	self digitalOutputNumber: decoder nextEncodedInt32.
	
	
	
	
]

{ #category : #request }
IOService >> receiveNotificationFromRobulab: aMessage [
	| data compteur |
	data := aMessage responseArray .
	compteur:=12.
]
