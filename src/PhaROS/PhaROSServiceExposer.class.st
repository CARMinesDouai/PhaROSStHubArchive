Class {
	#name : #PhaROSServiceExposer,
	#superclass : #Object,
	#instVars : [
		'serve',
		'name',
		'requestType',
		'responseType'
	],
	#category : #'PhaROS-Network-XmlRpc'
}

{ #category : #'as yet unclassified' }
PhaROSServiceExposer class >> new: aServiceName typedAs: aTypeID [
	^ self new name: aServiceName; type: (PhaROSTypeBrowser instance serviceDefinition: aTypeID); yourself.
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
PhaROSServiceExposer >> process: aRequest with: aResponse [
	^ serve value: aRequest value: aResponse
]

{ #category : #'as yet unclassified' }
PhaROSServiceExposer >> serve: aBlock [
	serve := aBlock
]

{ #category : #'as yet unclassified' }
PhaROSServiceExposer >> type: aType [
	requestType := aType at:1.
	responseType := aType at:2.
]
