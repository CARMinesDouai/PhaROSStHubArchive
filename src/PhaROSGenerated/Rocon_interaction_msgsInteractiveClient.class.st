Class {
	#name : #'Rocon_interaction_msgsInteractiveClient',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClient class >> rosMd5Sum [ 
^'8be6d4014d3005ac581b7b0a73488749'
]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClient class >> rosTypeDefinition [ 
^' string name
 uuid_msgs/UniqueID id
 rocon_std_msgs/MasterInfo platform_info
 string[] running_interactions
'
]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClient class >> rosTypeName [ 
^'rocon_interaction_msgs/InteractiveClient'
]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClient >> id [
	^ self getAt: #id. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClient >> id: aValue [
	^ self at: #id put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClient >> initialize [
	super initialize.
	 self name: ''. 
	 self id: Uuid_msgsUniqueID new. 
	 self platform_info: Rocon_std_msgsMasterInfo new. 
	 self running_interactions: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClient >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClient >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClient >> platform_info [
	^ self getAt: #platform_info. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClient >> platform_info: aValue [
	^ self at: #platform_info put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClient >> running_interactions [
	^ self getAt: #running_interactions. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteractiveClient >> running_interactions: aValue [
	^ self at: #running_interactions put: aValue. 

]
