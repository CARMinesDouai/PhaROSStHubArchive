Class {
	#name : #'Rocon_interaction_msgsInteractiveClients',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClients class >> rosMd5Sum [ 
^'5a5f85c169f63b30c61759b0bcca81c4'
]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClients class >> rosTypeDefinition [ 
^' rocon_interaction_msgs/InteractiveClient[] idle_clients
 rocon_interaction_msgs/InteractiveClient[] running_clients
'
]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClients class >> rosTypeName [ 
^'rocon_interaction_msgs/InteractiveClients'
]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClients class >> typeCreationOrder [ 
^229
]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClients >> idle_clients [
	^ self getAt: #idle_clients. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClients >> idle_clients: aValue [
	^ self at: #idle_clients put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClients >> initialize [
	super initialize.
	 self idle_clients: OrderedCollection new . 
	 self running_clients: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClients >> running_clients [
	^ self getAt: #running_clients. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClients >> running_clients: aValue [
	^ self at: #running_clients put: aValue. 

]
