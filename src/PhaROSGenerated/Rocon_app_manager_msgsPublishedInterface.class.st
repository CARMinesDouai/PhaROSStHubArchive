Class {
	#name : #'Rocon_app_manager_msgsPublishedInterface',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublishedInterface class >> rosMd5Sum [ 
^'0441e6f3dfb91bbff9a213da41a7a0d6'
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublishedInterface class >> rosTypeDefinition [ 
^' rocon_app_manager_msgs/PublicInterface interface
 string name
'
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublishedInterface class >> rosTypeName [ 
^'rocon_app_manager_msgs/PublishedInterface'
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublishedInterface >> initialize [
	super initialize.
	 self interface: Rocon_app_manager_msgsPublicInterface new. 
	 self name: ''. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublishedInterface >> interface [
	^ self getAt: #interface. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublishedInterface >> interface: aValue [
	^ self at: #interface put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublishedInterface >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublishedInterface >> name: aValue [
	^ self at: #name put: aValue. 

]
