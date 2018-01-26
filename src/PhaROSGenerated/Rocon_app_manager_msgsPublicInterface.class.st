Class {
	#name : #'Rocon_app_manager_msgsPublicInterface',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublicInterface class >> rosMd5Sum [ 
^'894455d729ec4bb7068b1f83aa87a23c'
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublicInterface class >> rosTypeDefinition [ 
^' string connection_type
 string data_type
 string name
'
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublicInterface class >> rosTypeName [ 
^'rocon_app_manager_msgs/PublicInterface'
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublicInterface class >> typeCreationOrder [ 
^216
]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublicInterface >> connection_type [
	^ self getAt: #connection_type. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublicInterface >> connection_type: aValue [
	^ self at: #connection_type put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublicInterface >> data_type [
	^ self getAt: #data_type. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublicInterface >> data_type: aValue [
	^ self at: #data_type put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublicInterface >> initialize [
	super initialize.
	 self connection_type: ''. 
	 self data_type: ''. 
	 self name: ''. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublicInterface >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Rocon_app_manager_msgsPublicInterface >> name: aValue [
	^ self at: #name put: aValue. 

]
