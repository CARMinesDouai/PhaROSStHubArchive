Class {
	#name : #'Rocon_std_msgsConnection',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnection class >> action_client [
	^'action_client'

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnection class >> action_server [
	^'action_server'

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnection class >> invalid [
	^'invalid'

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnection class >> publisher [
	^'publisher'

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnection class >> rosMd5Sum [ 
^'0dee991006513320090e2ee648136101'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnection class >> rosTypeDefinition [ 
^' string PUBLISHER=''publisher''
 string SUBSCRIBER=''subscriber''
 string SERVICE=''service''
 string ACTION_CLIENT=''action_client''
 string ACTION_SERVER=''action_server''
 string INVALID=''invalid''
 string type
 string name
 string node
 string type_msg
 string type_info
 string xmlrpc_uri
'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnection class >> rosTypeName [ 
^'rocon_std_msgs/Connection'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnection class >> service [
	^'service'

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnection class >> subscriber [
	^'subscriber'

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnection >> initialize [
	super initialize.
	 self type: ''. 
	 self name: ''. 
	 self node: ''. 
	 self type_msg: ''. 
	 self type_info: ''. 
	 self xmlrpc_uri: ''. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnection >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnection >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnection >> node [
	^ self getAt: #node. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnection >> node: aValue [
	^ self at: #node put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnection >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnection >> type: aValue [
	^ self at: #type put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnection >> type_info [
	^ self getAt: #type_info. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnection >> type_info: aValue [
	^ self at: #type_info put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnection >> type_msg [
	^ self getAt: #type_msg. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnection >> type_msg: aValue [
	^ self at: #type_msg put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnection >> xmlrpc_uri [
	^ self getAt: #xmlrpc_uri. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnection >> xmlrpc_uri: aValue [
	^ self at: #xmlrpc_uri put: aValue. 

]
