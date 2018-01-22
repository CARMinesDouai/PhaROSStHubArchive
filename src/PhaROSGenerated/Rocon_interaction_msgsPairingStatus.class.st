Class {
	#name : #'Rocon_interaction_msgsPairingStatus',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
