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

{ #category : #'instance creation' }
PNGService class >> newWithId: serviceId [

	^ self new id: serviceId; yourself
]

{ #category : #factory }
PNGService class >> serviceClassForType: serviceType [

	^ self allSubclasses detect: [:each | each serviceType  = serviceType]
			ifNone:[PNGUnknownService].
]

{ #category : #constants }
PNGService class >> serviceType [
	self subclassResponsibility
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
