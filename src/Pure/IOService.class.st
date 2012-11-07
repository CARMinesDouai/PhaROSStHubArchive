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
| data compteur compteurValue |
	Transcript show:'- - - - - - - - - -';cr.
	Transcript show: ' Acquisition des données du IO Service:';cr.	
	(self analogInputs isNil)ifTrue:[
		self analogOutputs: Dictionary new.
		self analogInputs: Dictionary new.
		self digitalOutputs: Dictionary new.
		self digitalInputs: Dictionary new.
		].
	data:= self get.
	compteur:=6.
	self analogInputNumber: (PDRConverter asInt32FromDataArray: data fromIndex: compteur).
	compteur := compteur+4.
	compteurValue:=1.
	self analogInputNumber timesRepeat: [
		self analogInputs at:compteurValue put: (PDRConverter asInt16FromDataArray: data fromIndex: compteur).
		compteurValue:=compteurValue+1.
		compteur:=compteur+2.
		].
	
	self analogOutputNumber: (PDRConverter asInt32FromDataArray: data fromIndex: compteur).
	compteur := compteur+4.
	compteurValue:=1.
	self analogOutputNumber timesRepeat: [
		self analogOutputs at:compteurValue put: (PDRConverter asInt16FromDataArray: data fromIndex: compteur).
		compteurValue:=compteurValue+1.
		compteur:=compteur+2.
		].
	
	self digitalInputNumber: (PDRConverter asInt32FromDataArray: data fromIndex: compteur).
	compteur := compteur+4.
	compteurValue:=1.
	(self digitalInputNumber/8) timesRepeat: [
		compteurValue:=compteurValue+8.
		compteur:=compteur+1.
		].
	
	self digitalOutputNumber: (PDRConverter asInt32FromDataArray: data fromIndex: compteur).
	compteur := compteur+4.
	compteurValue:=1.
	self digitalOutputNumber timesRepeat: [
		
		compteurValue:=compteurValue+1.
		compteur:=compteur+2.
		].
	
	
	
]

{ #category : #request }
IOService >> receiveNotificationFromRobulab: aMessage [
	| data compteur |
	data := aMessage responseArray .
	compteur:=12.
]
