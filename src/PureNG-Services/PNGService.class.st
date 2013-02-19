"
Subclasses must implement serviceType class side method

Instance Variables:
	id	<ProtoObject>
"
Class {
	#name : #PNGService,
	#superclass : #Object,
	#instVars : [
		'id',
		'robot'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'instance creation' }
PNGService class >> for: robulab [
	^self new
		robot: robulab;
		yourself
]

{ #category : #factory }
PNGService class >> isClass: each forServiceType: serviceType [
	^ (each class includesSelector: #serviceType) 
		and: [ each serviceType = serviceType ]
]

{ #category : #'instance creation' }
PNGService class >> newWithId: serviceId [

	^ self new id: serviceId; yourself
]

{ #category : #factory }
PNGService class >> serviceClassForType: serviceType [
	^ self allSubclasses detect: [ :each | self isClass: each forServiceType: serviceType ] ifNone: [ PNGUnknownService ]
]

{ #category : #constants }
PNGService class >> serviceType [
	self subclassResponsibility
]

{ #category : #actions }
PNGService >> decodeGetResponseFrom: decoder [
	| properties |
	properties := PNGLaserProperties new.
	^properties 
		x: decoder nextEncodedFloat32;
		y: decoder nextEncodedFloat32;
		orientation: decoder nextEncodedFloat32;
		echoesCount: decoder nextEncodedUInt32;
		yourself 
]

{ #category : #actions }
PNGService >> get [
	^self decodeGetResponseFrom: self primitiveGet decoder
]

{ #category : #actions }
PNGService >> getCommandString [
	"Byte       1             2         3-4
Content  Identifier  Action  Target"
	^ self subclassResponsibility 
]

{ #category : #accessing }
PNGService >> id [
	^ id
]

{ #category : #accessing }
PNGService >> id:  serviceId [
	id:= serviceId
]

{ #category : #actions }
PNGService >> primitiveGet [

	^self robot sendAndWaitForResult: self getCommandString.
]

{ #category : #accessing }
PNGService >> robot [
	^ robot
]

{ #category : #accessing }
PNGService >> robot: aRobulab [
	robot := aRobulab
]
