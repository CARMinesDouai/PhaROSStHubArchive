Class {
	#name : #PNGService,
	#superclass : #Object,
	#instVars : [
		'id'
	],
	#category : #'PureNG-Kernel'
}

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

{ #category : #accessing }
PNGService >> id [
	^ id
]

{ #category : #accessing }
PNGService >> id:  serviceId [
	id:= serviceId
]
