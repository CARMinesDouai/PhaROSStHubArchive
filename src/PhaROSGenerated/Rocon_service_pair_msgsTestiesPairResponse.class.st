Class {
	#name : #'Rocon_service_pair_msgsTestiesPairResponse',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPairResponse class >> rosMd5Sum [ 
^'05404c9fe275eda57650fdfced8cf402'
]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPairResponse class >> rosTypeDefinition [ 
^' uuid_msgs/UniqueID id
 rocon_service_pair_msgs/TestiesResponse response
'
]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPairResponse class >> rosTypeName [ 
^'rocon_service_pair_msgs/TestiesPairResponse'
]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPairResponse class >> typeCreationOrder [ 
^237
]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPairResponse >> id [
	^ self getAt: #id. 

]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPairResponse >> id: aValue [
	^ self at: #id put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPairResponse >> initialize [
	super initialize.
	 self id: Uuid_msgsUniqueID new. 
	 self response: Rocon_service_pair_msgsTestiesResponse new. 

]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPairResponse >> response [
	^ self getAt: #response. 

]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPairResponse >> response: aValue [
	^ self at: #response put: aValue. 

]
