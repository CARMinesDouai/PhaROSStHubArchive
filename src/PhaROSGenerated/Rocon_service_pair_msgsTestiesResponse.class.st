Class {
	#name : #'Rocon_service_pair_msgsTestiesResponse',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesResponse class >> rosTypeDefinition [ 
^' uuid_msgs/UniqueID id
 string data
'
]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesResponse class >> rosTypeName [ 
^'rocon_service_pair_msgs/TestiesResponse'
]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesResponse >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesResponse >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesResponse >> id [
	^ self getAt: #id. 

]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesResponse >> id: aValue [
	^ self at: #id put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesResponse >> initialize [
	super initialize.
	 self id: Uuid_msgsUniqueID new. 
	 self data: ''. 

]
