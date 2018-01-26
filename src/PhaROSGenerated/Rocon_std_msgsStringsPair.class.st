Class {
	#name : #'Rocon_std_msgsStringsPair',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsPair class >> rosMd5Sum [ 
^'d41c9071bd514be249c417a13ec83e65'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsPair class >> rosTypeDefinition [ 
^' rocon_std_msgs/StringsPairRequest pair_request
 rocon_std_msgs/StringsPairResponse pair_response
'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsPair class >> rosTypeName [ 
^'rocon_std_msgs/StringsPair'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsPair class >> typeCreationOrder [ 
^250
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsPair >> initialize [
	super initialize.
	 self pair_request: Rocon_std_msgsStringsPairRequest new. 
	 self pair_response: Rocon_std_msgsStringsPairResponse new. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsPair >> pair_request [
	^ self getAt: #pair_request. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsPair >> pair_request: aValue [
	^ self at: #pair_request put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsPair >> pair_response [
	^ self getAt: #pair_response. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsPair >> pair_response: aValue [
	^ self at: #pair_response put: aValue. 

]
