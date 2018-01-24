Class {
	#name : #'Rocon_interaction_msgsPairingStatus',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsPairingStatus class >> rosMd5Sum [ 
^'b404b2284f2d7e4f38394ad5a36be453'
]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsPairingStatus class >> rosTypeDefinition [ 
^' string active_pairing
'
]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsPairingStatus class >> rosTypeName [ 
^'rocon_interaction_msgs/PairingStatus'
]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsPairingStatus >> active_pairing [
	^ self getAt: #active_pairing. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsPairingStatus >> active_pairing: aValue [
	^ self at: #active_pairing put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsPairingStatus >> initialize [
	super initialize.
	 self active_pairing: ''. 

]
