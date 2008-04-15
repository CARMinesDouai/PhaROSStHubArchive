"
I have the purpose of changing the context of a niladic block so it can be evaluated in a remote image.
I serialize temps for transport so users of this service must be aware of what they ask me to transport in the temps.

Notable fact: remote objects in some temp, will be serialized and transported fine. In destination image thei will be deserialized and can be safely used as the local real objects. This was tested on proxies to objects in the same image where the context was asked to be evaluated.
"
Class {
	#name : #RSTRemoteValuable,
	#superclass : #Object,
	#instVars : [
		'source',
		'ast',
		'storage'
	],
	#category : #'rSTAdd-ons'
}

{ #category : #'instance creation' }
RSTRemoteValuable class >> for: aBlock [

	^ self new
		initializeOn: aBlock;
		yourself
]

{ #category : #actions }
RSTRemoteValuable >> assignTempVars: someTemps for: aBlock [
	"Asnwers aBlock with the storaged temps assigned."

	(self tempValuesFrom: someTemps) withIndexDo:[:aValue :anIndex|
		aBlock tempAt: anIndex put: aValue].
	
	^ aBlock 
]

{ #category : #accessing }
RSTRemoteValuable >> block [
	"Answers a block compiled in this image from source.
	Assign to it the temporary variables stored in the receiver."

	self assert: source notNil.
	self assert: ast notNil.
	
	^ self declareAndAssignTempVarsFor: source 

]

{ #category : #actions }
RSTRemoteValuable >> compile: aNiladicBlockSource [

	^ Compiler evaluate: aNiladicBlockSource 
]

{ #category : #actions }
RSTRemoteValuable >> declareAndAssignTempVarsFor: aNiladicBlockSource [ 
	"Adds the declaration and the 
	values to the temporary variables."
	| src temps |
	src := RWBinaryOrTextStream on: String new.
	^ [temps := self tempVars.
	temps isEmpty ifTrue:[^self compile: aNiladicBlockSource].
	
	self 
		declareTempVars: temps on: src;
		yourself.
	src cr; nextPutAll: source.
	self assignTempVars: temps for: (self compile: src contents)]
		on: Error
		do:[:x| RSTRemoteValuableError signal: 'Can''t rebuild the valuable in this host']
	
]

{ #category : #actions }
RSTRemoteValuable >> declareTempVars: temps on: aStream [
	"Adds the declaration of the temporary variables."

	aStream nextPut: $|.

	self parsedTree body temporaries do:[:aTempNode|
		aStream space; nextPutAll: aTempNode name].
	aStream space; nextPut: $|.
	
]

{ #category : #actions }
RSTRemoteValuable >> deserialize: aByteArray [
	
	^ ReferenceStream unStream: aByteArray 
]

{ #category : #actions }
RSTRemoteValuable >> getSourceFrom: aBlock [
	"Answers the source code of aBlock strictly 
	necessary to re compile it somewhere else."
	
	| str src |
	
	"Strips unnecessary code"
	str := ReadStream on: aBlock method getSource.
	str upTo: $[.
	src := str upToEnd reversed.
	str := ReadStream on: src.
	str upTo: $].
	^ '[', str upToEnd reversed,']'.
	

]

{ #category : #actions }
RSTRemoteValuable >> getTempsFrom: aBlock [
	"Answers the temporary variables names associated
	to its values ordered as aBlock's temp index expects to find them."

	^ aBlock tempNames withIndexCollect:[:name :index|
		name -> (aBlock tempAt: index)]
]

{ #category : #initializing }
RSTRemoteValuable >> initializeOn: aBlock [
	"Initializes the receiver on aBlock."
	
	"Get the code version of aBlock"
	source := self getSourceFrom: aBlock.
	ast := self serialize: aBlock method parseTree.
	"Get the temp vars used in aBlock"
	self store: (self getTempsFrom: aBlock).
]

{ #category : #accessing }
RSTRemoteValuable >> parsedTree [
	"Answers the Abstract Syntax Tree of the valuable"
	^ self deserialize: ast
]

{ #category : #accessing }
RSTRemoteValuable >> remoteType [
	"Answer the prefered way to go to other image (#reference or #copy)"
	
	"This receiver uses #copy because its meaning in life is
	to provide support to move valuable's context from one 
	image to another."
	^ #copy
]

{ #category : #actions }
RSTRemoteValuable >> serialize: anObject [
	
	^ ReferenceStream streamedRepresentationOf: anObject
]

{ #category : #actions }
RSTRemoteValuable >> store: tempVars [
	"Store the tempVars in a way the receiver 
	can carry them in its trek."
	
	storage := self serialize: tempVars
]

{ #category : #accessing }
RSTRemoteValuable >> tempValuesFrom: someTemps [
	"Answers the values of the temps in the order
	the compiled block expects them."
	
	^ self parsedTree body temporaries collect:[:node|
		(someTemps detect:[:e| e key = node name]) value]
]

{ #category : #accessing }
RSTRemoteValuable >> tempVars [
	"Answers the tempVars stored by the receiver."
	
	^ self deserialize: storage
]

{ #category : #actions }
RSTRemoteValuable >> value [
	"Evaluates the valuable in this image"
	
	^ self block value
]
