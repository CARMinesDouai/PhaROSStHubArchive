Class {
	#name : #'Rocon_service_pair_msgsTestiesRequest',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesRequest class >> rosMd5Sum [ 
^'992ce8a1687cec8c8bd883ec73ca41d1'
]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesRequest class >> rosTypeDefinition [ 
^' string data
'
]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesRequest class >> rosTypeName [ 
^'rocon_service_pair_msgs/TestiesRequest'
]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesRequest class >> typeCreationOrder [ 
^234
]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesRequest >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesRequest >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesRequest >> initialize [
	super initialize.
	 self data: ''. 

]
