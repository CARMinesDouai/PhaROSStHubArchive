Class {
	#name : #'Rocon_app_manager_msgsRappList',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRappList class >> rosMd5Sum [ 
^'796706b807515187050df80223ad161e'
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRappList class >> rosTypeDefinition [ 
^' rocon_app_manager_msgs/Rapp[] available_rapps
'
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRappList class >> rosTypeName [ 
^'rocon_app_manager_msgs/RappList'
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRappList class >> typeCreationOrder [ 
^221
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRappList >> available_rapps [
	^ self getAt: #available_rapps. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRappList >> available_rapps: aValue [
	^ self at: #available_rapps put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRappList >> initialize [
	super initialize.
	 self available_rapps: OrderedCollection new . 

]
