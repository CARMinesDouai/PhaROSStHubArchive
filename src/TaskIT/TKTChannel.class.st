Class {
	#name : #TKTChannel,
	#superclass : #Object,
	#instVars : [
		'queue'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #'as yet unclassified' }
TKTChannel >> broadcast: anObject [
	"put an object that all the consumers will receive".
]

{ #category : #'as yet unclassified' }
TKTChannel >> initialize [ 
	queue := TKTQueue new.
]

{ #category : #'as yet unclassified' }
TKTChannel >> peek [
	"look for an object, if is nothing, returns nil"
]

{ #category : #'as yet unclassified' }
TKTChannel >> pick [
	"wait for an object"
]

{ #category : #'as yet unclassified' }
TKTChannel >> put: anObject [
	"add a consumable object into the channel. The first process that take it is the new owner"
	^ queue add: anObject.
]
