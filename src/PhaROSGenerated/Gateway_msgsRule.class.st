Class {
	#name : #'Gateway_msgsRule',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Gateway_msgsRule class >> rosMd5Sum [ 
^'7a98759a4c27c4925840d27b3d7bcecb'
]

{ #category : #'as yet unclassified' }
Gateway_msgsRule class >> rosTypeDefinition [ 
^' string type
 string name
 string node
'
]

{ #category : #'as yet unclassified' }
Gateway_msgsRule class >> rosTypeName [ 
^'gateway_msgs/Rule'
]

{ #category : #'as yet unclassified' }
Gateway_msgsRule class >> typeCreationOrder [ 
^121
]

{ #category : #'as yet unclassified' }
Gateway_msgsRule >> initialize [
	super initialize.
	 self type: ''. 
	 self name: ''. 
	 self node: ''. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRule >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRule >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRule >> node [
	^ self getAt: #node. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRule >> node: aValue [
	^ self at: #node put: aValue. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRule >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
Gateway_msgsRule >> type: aValue [
	^ self at: #type put: aValue. 

]
