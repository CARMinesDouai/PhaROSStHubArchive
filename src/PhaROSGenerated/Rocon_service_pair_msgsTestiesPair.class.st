Class {
	#name : #'Rocon_service_pair_msgsTestiesPair',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPair class >> rosMd5Sum [ 
^'7b5cb9b4ccdb74840ce04ea92d2a141d'
]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPair class >> rosTypeDefinition [ 
^' rocon_service_pair_msgs/TestiesPairRequest pair_request
 rocon_service_pair_msgs/TestiesPairResponse pair_response
'
]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPair class >> rosTypeName [ 
^'rocon_service_pair_msgs/TestiesPair'
]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPair class >> typeCreationOrder [ 
^238
]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPair >> initialize [
	super initialize.
	 self pair_request: Rocon_service_pair_msgsTestiesPairRequest new. 
	 self pair_response: Rocon_service_pair_msgsTestiesPairResponse new. 

]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPair >> pair_request [
	^ self getAt: #pair_request. 

]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPair >> pair_request: aValue [
	^ self at: #pair_request put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPair >> pair_response [
	^ self getAt: #pair_response. 

]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesPair >> pair_response: aValue [
	^ self at: #pair_response put: aValue. 

]
