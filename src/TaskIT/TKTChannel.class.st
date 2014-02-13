Class {
	#name : #TKTChannel,
	#superclass : #Object,
	#instVars : [
		'queue'
	],
	#category : #'TaskIT-Channel'
}

{ #category : #accessing }
TKTChannel >> broadcast: anObject [
	"put an object that all the consumers will receive".
]

{ #category : #'initialize-release' }
TKTChannel >> initialize [ 
	queue := TKTQueue new.
	queue timeout: 60 * 1000.
]

{ #category : #accessing }
TKTChannel >> peek [
	"look for an object, if is nothing, returns nil"
	^ queue peek.
]

{ #category : #accessing }
TKTChannel >> pick [
	"wait for an object"
	^ queue next.
]

{ #category : #private }
TKTChannel >> put: anObject [
	"add a consumable object into the channel. The first process that take it is the new owner"
	^ queue add: anObject.
]
