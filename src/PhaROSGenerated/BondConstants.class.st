Class {
	#name : #BondConstants,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
BondConstants class >> dead_publish_period [
	^0.05

]

{ #category : #'as yet unclassified' }
BondConstants class >> default_connect_timeout [
	^10.0

]

{ #category : #'as yet unclassified' }
BondConstants class >> default_disconnect_timeout [
	^2.0

]

{ #category : #'as yet unclassified' }
BondConstants class >> default_heartbeat_period [
	^1.0

]

{ #category : #'as yet unclassified' }
BondConstants class >> default_heartbeat_timeout [
	^4.0

]

{ #category : #'as yet unclassified' }
BondConstants class >> disable_heartbeat_timeout_param [
	^'/bond_disable_heartbeat_timeout'

]

{ #category : #'as yet unclassified' }
BondConstants class >> rosMd5Sum [ 
^'6fc594dc1d7bd7919077042712f8c8b0'
]

{ #category : #'as yet unclassified' }
BondConstants class >> rosTypeDefinition [ 
^' float32 DEAD_PUBLISH_PERIOD=0.05
 float32 DEFAULT_CONNECT_TIMEOUT=10.0
 float32 DEFAULT_HEARTBEAT_TIMEOUT=4.0
 float32 DEFAULT_DISCONNECT_TIMEOUT=2.0
 float32 DEFAULT_HEARTBEAT_PERIOD=1.0
 string DISABLE_HEARTBEAT_TIMEOUT_PARAM=''/bond_disable_heartbeat_timeout''
'
]

{ #category : #'as yet unclassified' }
BondConstants class >> rosTypeName [ 
^'bond/Constants'
]

{ #category : #'as yet unclassified' }
BondConstants class >> typeCreationOrder [ 
^46
]

{ #category : #'as yet unclassified' }
BondConstants >> initialize [
	super initialize.

]
