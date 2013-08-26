Class {
	#name : #PhaROSExternalNode,
	#superclass : #Object,
	#instVars : [
		'name',
		'topic',
		'socket'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #accessing }
PhaROSExternalNode >> checkConnection [
	socket isConnected ifFalse:[
		PhaROSError signal: 'Socket closed'.	
	].

]

{ #category : #accessing }
PhaROSExternalNode >> finalize [
	socket close.
]

{ #category : #accessing }
PhaROSExternalNode >> name [
	^ name
]

{ #category : #accessing }
PhaROSExternalNode >> name: aName [
	name := aName.
	
]

{ #category : #accessing }
PhaROSExternalNode >> socket [ 
	^ socket.
]

{ #category : #accessing }
PhaROSExternalNode >> socket: aSocket [
	socket := aSocket. 
]

{ #category : #accessing }
PhaROSExternalNode >> topic [
	^ topic
]

{ #category : #accessing }
PhaROSExternalNode >> topic: aTopic [ 
	topic := aTopic.
	
]
