Class {
	#name : #PhaROSServiceType,
	#superclass : #Object,
	#instVars : [
		'request',
		'response',
		'md5sum',
		'typeName'
	],
	#category : #'PhaROS-Util'
}

{ #category : #'as yet unclassified' }
PhaROSServiceType >> md5Sum [
	^ md5sum
]

{ #category : #'as yet unclassified' }
PhaROSServiceType >> md5Sum: aHash [	
	md5sum := aHash
]

{ #category : #'as yet unclassified' }
PhaROSServiceType >> request [
	^ request
]

{ #category : #'as yet unclassified' }
PhaROSServiceType >> request: aRequestType [
	request  := aRequestType .
]

{ #category : #'as yet unclassified' }
PhaROSServiceType >> response [
	^ response
]

{ #category : #'as yet unclassified' }
PhaROSServiceType >> response: aResponseType [
	response  := aResponseType .
]

{ #category : #'as yet unclassified' }
PhaROSServiceType >> typeName [
	^ typeName
]

{ #category : #'as yet unclassified' }
PhaROSServiceType >> typeName: aName [
	typeName := aName
]
