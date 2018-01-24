Class {
	#name : #'Rocon_interaction_msgsPairing',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsPairing class >> rosMd5Sum [ 
^'ea0c053e41db2888c64e24c141e32271'
]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsPairing class >> rosTypeDefinition [ 
^' string name
 string rapp
 string description
 rocon_std_msgs/Icon icon
 rocon_std_msgs/Remapping[] remappings
 rocon_std_msgs/KeyValue[] parameters
'
]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsPairing class >> rosTypeName [ 
^'rocon_interaction_msgs/Pairing'
]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsPairing >> description [
	^ self getAt: #description. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsPairing >> description: aValue [
	^ self at: #description put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsPairing >> icon [
	^ self getAt: #icon. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsPairing >> icon: aValue [
	^ self at: #icon put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsPairing >> initialize [
	super initialize.
	 self name: ''. 
	 self rapp: ''. 
	 self description: ''. 
	 self icon: Rocon_std_msgsIcon new. 
	 self remappings: OrderedCollection new . 
	 self parameters: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsPairing >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsPairing >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsPairing >> parameters [
	^ self getAt: #parameters. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsPairing >> parameters: aValue [
	^ self at: #parameters put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsPairing >> rapp [
	^ self getAt: #rapp. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsPairing >> rapp: aValue [
	^ self at: #rapp put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsPairing >> remappings [
	^ self getAt: #remappings. 

]

{ #category : #'as yet unclassified' }
Rocon_interaction_msgsPairing >> remappings: aValue [
	^ self at: #remappings put: aValue. 

]
