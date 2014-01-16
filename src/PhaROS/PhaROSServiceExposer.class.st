Class {
	#name : #PhaROSServiceExposer,
	#superclass : #Object,
	#instVars : [
		'serve',
		'name',
		'owner',
		'typeID',
		'type'
	],
	#category : #'PhaROS-Network-XmlRpc'
}

{ #category : #'as yet unclassified' }
PhaROSServiceExposer class >> new: aServiceName typedAs: aTypeID [
	^ self new name: aServiceName; type: (PhaROSTypeBrowser instance serviceDefinition: aTypeID); yourself.
]

{ #category : #'as yet unclassified' }
PhaROSServiceExposer >> md5Sum [
	^ type md5Sum.
]

{ #category : #'as yet unclassified' }
PhaROSServiceExposer >> name [
	^ name
]

{ #category : #'as yet unclassified' }
PhaROSServiceExposer >> name: aName [
	
	name := aName
]

{ #category : #'as yet unclassified' }
PhaROSServiceExposer >> owner [
	^ owner
]

{ #category : #'as yet unclassified' }
PhaROSServiceExposer >> owner: aNode [
	owner:= aNode
]

{ #category : #'as yet unclassified' }
PhaROSServiceExposer >> process: aRequest with: aResponse [
	^ serve value: aRequest value: aResponse
]

{ #category : #'as yet unclassified' }
PhaROSServiceExposer >> requestType [
	^ type request.
]

{ #category : #'as yet unclassified' }
PhaROSServiceExposer >> responseType [
	^ type response
]

{ #category : #'as yet unclassified' }
PhaROSServiceExposer >> serve: aBlock [
	serve := aBlock
]

{ #category : #'as yet unclassified' }
PhaROSServiceExposer >> type [
	^ type
]

{ #category : #'as yet unclassified' }
PhaROSServiceExposer >> type: aType [
	type := aType.

]
