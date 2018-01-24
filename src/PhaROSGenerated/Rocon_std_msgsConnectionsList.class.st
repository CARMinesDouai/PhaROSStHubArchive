Class {
	#name : #'Rocon_std_msgsConnectionsList',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsList class >> rosMd5Sum [ 
^'672d6ad69b684884f8fb6f4acedbd39f'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsList class >> rosTypeDefinition [ 
^' rocon_std_msgs/Connection[] connections
'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsList class >> rosTypeName [ 
^'rocon_std_msgs/ConnectionsList'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsList >> connections [
	^ self getAt: #connections. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsList >> connections: aValue [
	^ self at: #connections put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsConnectionsList >> initialize [
	super initialize.
	 self connections: OrderedCollection new . 

]
