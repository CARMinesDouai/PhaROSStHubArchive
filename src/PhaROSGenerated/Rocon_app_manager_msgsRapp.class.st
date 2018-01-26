Class {
	#name : #'Rocon_app_manager_msgsRapp',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp class >> rosMd5Sum [ 
^'0214a3ee298e9d3ae08c6ab15b8e910d'
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp class >> rosTypeDefinition [ 
^' string name
 string display_name
 string description
 string compatibility
 string status
 string[] implementations
 string preferred
 rocon_std_msgs/Icon icon
 rocon_std_msgs/KeyValue[] public_interface
 rocon_std_msgs/KeyValue[] public_parameters
'
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp class >> rosTypeName [ 
^'rocon_app_manager_msgs/Rapp'
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp class >> typeCreationOrder [ 
^220
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp >> compatibility [
	^ self getAt: #compatibility. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp >> compatibility: aValue [
	^ self at: #compatibility put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp >> description [
	^ self getAt: #description. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp >> description: aValue [
	^ self at: #description put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp >> display_name [
	^ self getAt: #display_name. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp >> display_name: aValue [
	^ self at: #display_name put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp >> icon [
	^ self getAt: #icon. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp >> icon: aValue [
	^ self at: #icon put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp >> implementations [
	^ self getAt: #implementations. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp >> implementations: aValue [
	^ self at: #implementations put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp >> initialize [
	super initialize.
	 self name: ''. 
	 self display_name: ''. 
	 self description: ''. 
	 self compatibility: ''. 
	 self status: ''. 
	 self implementations: OrderedCollection new . 
	 self preferred: ''. 
	 self icon: Rocon_std_msgsIcon new. 
	 self public_interface: OrderedCollection new . 
	 self public_parameters: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp >> preferred [
	^ self getAt: #preferred. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp >> preferred: aValue [
	^ self at: #preferred put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp >> public_interface [
	^ self getAt: #public_interface. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp >> public_interface: aValue [
	^ self at: #public_interface put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp >> public_parameters [
	^ self getAt: #public_parameters. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp >> public_parameters: aValue [
	^ self at: #public_parameters put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsRapp >> status: aValue [
	^ self at: #status put: aValue. 

]
