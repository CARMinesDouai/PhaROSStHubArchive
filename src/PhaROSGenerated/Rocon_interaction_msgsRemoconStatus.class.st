Class {
	#name : #'Rocon_interaction_msgsRemoconStatus',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsRemoconStatus class >> rosMd5Sum [ 
^'a586408ad56a017fbadae95562c0c018'
]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsRemoconStatus class >> rosTypeDefinition [ 
^' rocon_std_msgs/MasterInfo platform_info
 string uuid
 int32[] running_interactions
 string version
'
]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsRemoconStatus class >> rosTypeName [ 
^'rocon_interaction_msgs/RemoconStatus'
]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsRemoconStatus >> initialize [
	super initialize.
	 self platform_info: Rocon_std_msgsMasterInfo new. 
	 self uuid: ''. 
	 self running_interactions: OrderedCollection new . 
	 self version: ''. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsRemoconStatus >> platform_info [
	^ self getAt: #platform_info. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsRemoconStatus >> platform_info: aValue [
	^ self at: #platform_info put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsRemoconStatus >> running_interactions [
	^ self getAt: #running_interactions. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsRemoconStatus >> running_interactions: aValue [
	^ self at: #running_interactions put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsRemoconStatus >> uuid [
	^ self getAt: #uuid. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsRemoconStatus >> uuid: aValue [
	^ self at: #uuid put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsRemoconStatus >> version [
	^ self getAt: #version. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsRemoconStatus >> version: aValue [
	^ self at: #version put: aValue. 

]
