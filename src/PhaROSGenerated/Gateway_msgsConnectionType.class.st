Class {
	#name : #'Gateway_msgsConnectionType',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionType class >> action_client [
	^'action_client'

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionType class >> action_server [
	^'action_server'

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionType class >> invalid [
	^'invalid'

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionType class >> publisher [
	^'publisher'

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionType class >> rosMd5Sum [ 
^'65d75f1bb32566bfec48966db2073c81'
]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionType class >> rosTypeDefinition [ 
^' string PUBLISHER=''publisher''
 string SUBSCRIBER=''subscriber''
 string SERVICE=''service''
 string ACTION_CLIENT=''action_client''
 string ACTION_SERVER=''action_server''
 string INVALID=''invalid''
'
]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionType class >> rosTypeName [ 
^'gateway_msgs/ConnectionType'
]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionType class >> service [
	^'service'

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionType class >> subscriber [
	^'subscriber'

]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionType class >> typeCreationOrder [ 
^119
]

{ #category : #'as yet unclassified' }
Gateway_msgsConnectionType >> initialize [
	super initialize.

]
