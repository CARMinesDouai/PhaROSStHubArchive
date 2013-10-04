Class {
	#name : #SSDedicatedThreadStrategy,
	#superclass : #SSIOStrategy,
	#instVars : [
		'buffer',
		'reader'
	],
	#category : #'StarGazer-Stream'
}

{ #category : #'as yet unclassified' }
SSDedicatedThreadStrategy >> becomeMonothread [ 
	self stopReader.
	^ super becomeMonothread.
]

{ #category : #'as yet unclassified' }
SSDedicatedThreadStrategy >> cleanUpBuffer [ 
	buffer peekAll.
]

{ #category : #'as yet unclassified' }
SSDedicatedThreadStrategy >> configure [
	buffer := TKTQueue new.
	self startReader.
]

{ #category : #'as yet unclassified' }
SSDedicatedThreadStrategy >> consumePort [
	| read |
	read := self readPort.
	
	(read isNil or: [ read isEmpty ]) ifFalse: [
		buffer add: read. 
	].
 	(Delay forMilliseconds: 10) wait.
]

{ #category : #'as yet unclassified' }
SSDedicatedThreadStrategy >> nextPut: aCharacter [
	self error: 'nextPut: is not supported by the threaded strategy. You should use nextPutAll: or switch to mono thread strategy'.
]

{ #category : #'as yet unclassified' }
SSDedicatedThreadStrategy >> nextPutAll: anArrayOfCharacters [ 
	| ret |
	self stopReader.
	ret := super nextPutAll: anArrayOfCharacters.
	self startReader.
]

{ #category : #'as yet unclassified' }
SSDedicatedThreadStrategy >> read [
	| next read |
	
	next := buffer next. 
	next ifNil: [ ^ ''].
	read := '' join: ({ next }, buffer peekAll ).
"	Transcript show:' READ ', read ; cr.
	Transcript show:'~ : ' , (read indexOf: $~ ifAbsent:[ 'NO HAY ' ]) asString ;cr ."
	^ read.
]

{ #category : #'as yet unclassified' }
SSDedicatedThreadStrategy >> startReader [ 
	reader := self paralellize looping consumePort asStickyReference.
	
	
]

{ #category : #'as yet unclassified' }
SSDedicatedThreadStrategy >> stopReader [ 
	reader ifNotNil: [ 
		reader finalize. 
		reader := nil.
	].
]
