Class {
	#name : #'Gateway_msgsRemoteRule',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteRule class >> rosMd5Sum [ 
^'14f4c5aaf33b32b22c50fd514747f99f'
]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteRule class >> rosTypeDefinition [ 
^' string gateway
 gateway_msgs/Rule rule
'
]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteRule class >> rosTypeName [ 
^'gateway_msgs/RemoteRule'
]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteRule >> gateway [
	^ self getAt: #gateway. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteRule >> gateway: aValue [
	^ self at: #gateway put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteRule >> initialize [
	super initialize.
	 self gateway: ''. 
	 self rule: Gateway_msgsRule new. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteRule >> rule [
	^ self getAt: #rule. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRemoteRule >> rule: aValue [
	^ self at: #rule put: aValue. 

]
