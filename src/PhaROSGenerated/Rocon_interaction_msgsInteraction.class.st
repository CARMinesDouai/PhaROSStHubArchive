Class {
	#name : #'Rocon_interaction_msgsInteraction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction class >> rosMd5Sum [ 
^'a118201d77d4921a4dbca2d7a413a812'
]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction class >> rosTypeDefinition [ 
^' int32 UNLIMITED_INTERACTIONS=-1
 string name
 string command
 string compatibility
 string group
 string description
 rocon_std_msgs/Icon icon
 string namespace
 rocon_std_msgs/Remapping[] remappings
 string parameters
 int32 max
 bool bringup_pairing
 bool teardown_pairing
 string[] required_pairings
 int32 hash
'
]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction class >> rosTypeName [ 
^'rocon_interaction_msgs/Interaction'
]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction class >> unlimited_interactions [
	^-1

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> bringup_pairing [
	^ self getAt: #bringup_pairing. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> bringup_pairing: aValue [
	^ self at: #bringup_pairing put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> command [
	^ self getAt: #command. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> command: aValue [
	^ self at: #command put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> compatibility [
	^ self getAt: #compatibility. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> compatibility: aValue [
	^ self at: #compatibility put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> description [
	^ self getAt: #description. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> description: aValue [
	^ self at: #description put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> group [
	^ self getAt: #group. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> group: aValue [
	^ self at: #group put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> hash [
	^ self getAt: #hash. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> hash: aValue [
	^ self at: #hash put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> icon [
	^ self getAt: #icon. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> icon: aValue [
	^ self at: #icon put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> initialize [
	super initialize.
	 self name: ''. 
	 self command: ''. 
	 self compatibility: ''. 
	 self group: ''. 
	 self description: ''. 
	 self icon: Rocon_std_msgsIcon new. 
	 self namespace: ''. 
	 self remappings: OrderedCollection new . 
	 self parameters: ''. 
	 self max: 0. 
	 self bringup_pairing: false. 
	 self teardown_pairing: false. 
	 self required_pairings: OrderedCollection new . 
	 self hash: 0. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> max [
	^ self getAt: #max. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> max: aValue [
	^ self at: #max put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> namespace [
	^ self getAt: #namespace. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> namespace: aValue [
	^ self at: #namespace put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> parameters [
	^ self getAt: #parameters. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> parameters: aValue [
	^ self at: #parameters put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> remappings [
	^ self getAt: #remappings. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> remappings: aValue [
	^ self at: #remappings put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> required_pairings [
	^ self getAt: #required_pairings. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> required_pairings: aValue [
	^ self at: #required_pairings put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> teardown_pairing [
	^ self getAt: #teardown_pairing. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsInteraction >> teardown_pairing: aValue [
	^ self at: #teardown_pairing put: aValue. 

]
