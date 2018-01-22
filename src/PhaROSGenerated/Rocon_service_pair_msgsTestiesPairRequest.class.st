Class {
	#name : #'Rocon_service_pair_msgsTestiesPairRequest',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPairRequest class >> rosTypeDefinition [ 
^' uuid_msgs/UniqueID id
 rocon_service_pair_msgs/TestiesRequest request
'
]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPairRequest class >> rosTypeName [ 
^'rocon_service_pair_msgs/TestiesPairRequest'
]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPairRequest >> id [
	^ self getAt: #id. 

]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPairRequest >> id: aValue [
	^ self at: #id put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPairRequest >> initialize [
	super initialize.
	 self id: Uuid_msgsUniqueID new. 
	 self request: Rocon_service_pair_msgsTestiesRequest new. 

]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPairRequest >> request [
	^ self getAt: #request. 

]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPairRequest >> request: aValue [
	^ self at: #request put: aValue. 

]
